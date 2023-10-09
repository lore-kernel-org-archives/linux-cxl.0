Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC691A72A
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CA4E0
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 09:36:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S44Ng5RTlz67ySC;
	Tue, 10 Oct 2023 00:33:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 9 Oct
 2023 17:36:53 +0100
Date: Mon, 9 Oct 2023 17:36:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] cxl/pci: Remove hardirq handler for
 cxl_request_irq()
Message-ID: <20231009173652.00004491@Huawei.com>
In-Reply-To: <169657717635.1491153.10040969889268437662.stgit@dwillia2-xfh.jf.intel.com>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
	<169657717635.1491153.10040969889268437662.stgit@dwillia2-xfh.jf.intel.com>
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
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 06 Oct 2023 00:26:16 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Now that all callers of cxl_request_irq() are using threaded irqs, drop
> the hardirq handler option.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Makes sense.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 49d9b2ef5c5c..dc665b12be8f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -90,7 +90,7 @@ struct cxl_dev_id {
>  };
>  
>  static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
> -			   irq_handler_t handler, irq_handler_t thread_fn)
> +			   irq_handler_t thread_fn)
>  {
>  	struct device *dev = cxlds->dev;
>  	struct cxl_dev_id *dev_id;
> @@ -101,9 +101,9 @@ static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
>  		return -ENOMEM;
>  	dev_id->cxlds = cxlds;
>  
> -	return devm_request_threaded_irq(dev, irq, handler, thread_fn,
> -					 IRQF_SHARED | IRQF_ONESHOT,
> -					 NULL, dev_id);
> +	return devm_request_threaded_irq(dev, irq, NULL, thread_fn,
> +					 IRQF_SHARED | IRQF_ONESHOT, NULL,
> +					 dev_id);
>  }
>  
>  static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
> @@ -440,7 +440,7 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	if (irq < 0)
>  		return 0;
>  
> -	if (cxl_request_irq(cxlds, irq, NULL, cxl_pci_mbox_irq))
> +	if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq))
>  		return 0;
>  
>  	dev_dbg(cxlds->dev, "Mailbox interrupts enabled\n");
> @@ -638,7 +638,7 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>  	if (irq < 0)
>  		return irq;
>  
> -	return cxl_request_irq(cxlds, irq, NULL, cxl_event_thread);
> +	return cxl_request_irq(cxlds, irq, cxl_event_thread);
>  }
>  
>  static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
> 
> 

