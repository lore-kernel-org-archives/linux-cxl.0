Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC5C12E6D
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56291
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 13:41:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5PjX2nxGz67VcY;
	Thu, 12 Oct 2023 04:38:08 +0800 (CST)
Received: from localhost (10.126.175.8) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 21:41:11 +0100
Date: Wed, 11 Oct 2023 21:41:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jim Harris <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] cxl/region: don't try to cleanup after
 cxl_region_setup_targets() fails
Message-ID: <20231011214110.0000365b@Huawei.com>
In-Reply-To: <169703589120.1202031.14696100866518083806.stgit@bgt-140510-bm03.eng.stellus.in>
References: <169696311899.1171696.7812961484055097837.stgit@bgt-140510-bm03.eng.stellus.in>
	<CGME20231011145132uscas1p13e9fb6dadfa3d5b61fc410449122a013@uscas1p1.samsung.com>
	<169703589120.1202031.14696100866518083806.stgit@bgt-140510-bm03.eng.stellus.in>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.8]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 11 Oct 2023 14:51:31 +0000
Jim Harris <jim.harris@samsung.com> wrote:

> Patch 5e42bcbc ("cxl/region: decrement ->nr_targets on error in
> cxl_region_attach()") tried to avoid 'eiw' initialization errors when
> ->nr_targets exceeded 16, by just decrementing ->nr_targets when  
> cxl_region_setup_targets() failed. Patch 86987c76 ("cxl/region: Cleanup
> target list on attach error") extended that cleanup to also clear
> cxled->pos and p->targets[pos].
> 
> The initialization error was incidentally fixed separately by patch
> 8d4285425 ("cxl/region: Fix port setup uninitialized variable warnings")
> which was merged a few days after 5e42bcbc.
> 
> But now the original cleanup when cxl_region_setup_targets() fails
> prevents endpoint and switch decoder resources from being reused:
> 
> 1) the cleanup does not set the decoder's region to NULL, which results
>    in future dpa_size_store() calls returning -EBUSY
> 2) the decoder is not properly freed, which results in future commit
>    errors associated with the upstream switch
> 
> Now that the initialization errors were fixed separately, the proper
> cleanup for this case is to just return immediately. Then the resources
> associated with this target get cleanup up as normal when the failed
> region is deleted.
> 
> The ->nr_targets decrement in the error case also helped prevent
> a p->targets[] array overflow, so add a new check to prevent against
> that overflow.
> 
> Tested by trying to create an invalid region for a 2 switch * 2 endpoint
> topology, and then following up with creating a valid region.
> 
> Signed-off-by: Jim Harris <jim.harris@samsung.com>

I agree with your analysis and that this seems to fix the cases you've called out.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/cxl/core/region.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..2b3b3c62d0a7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1658,6 +1658,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> +	if (p->nr_targets >= p->interleave_ways) {
> +		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
> +			p->nr_targets);
> +		return -EINVAL;
> +	}
> +
>  	ep_port = cxled_to_port(cxled);
>  	root_port = cxlrd_to_port(cxlrd);
>  	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
> @@ -1750,7 +1756,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	if (p->nr_targets == p->interleave_ways) {
>  		rc = cxl_region_setup_targets(cxlr);
>  		if (rc)
> -			goto err_decrement;
> +			return rc;
>  		p->state = CXL_CONFIG_ACTIVE;
>  	}
>  
> @@ -1762,12 +1768,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	};
>  
>  	return 0;
> -
> -err_decrement:
> -	p->nr_targets--;
> -	cxled->pos = -1;
> -	p->targets[pos] = NULL;
> -	return rc;
>  }
>  
>  static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> 

