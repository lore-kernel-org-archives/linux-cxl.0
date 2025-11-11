Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A40366560;
	Tue, 11 Nov 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875411; cv=none; b=G9ZhbG9eK0Lbxg1KAeQ9foZfdBvkqQJ/tLJpTz3LQFqUpzjd4jOfoRl8ZTxeWnGnZgi0Y/0djLzB0RsQp77QKpdPmsQNbWCr5QfUkeJC08KtawAJ/7dyhfp2T1tqHydRKWOlgyYs9BrQCJuN1IePQMm5Z2gzqkzL9PCD9Gk1f7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875411; c=relaxed/simple;
	bh=oRo8XMvH7Pu2q88qkH8f1jma9N+uA/qxX+1TD2qlLDU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeAfQkst51xC5ZRa+MIBWpvbCQ1eW/kM0CnvPXJegY9auqYJBMTkR8Bka36+4uzRyzFZHZ7DLGQ+TA41VgUnv/hQmGHAtSVu2TuQvspAloZA4KIFCcpTrbmLyfjpN4DoMIrMTmCQXfslG7Ua55pgEOvxlRZvhTHB7eQMZ9mjurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5Vxm69vGzHnH6b;
	Tue, 11 Nov 2025 23:36:28 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 33E43140370;
	Tue, 11 Nov 2025 23:36:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:36:45 +0000
Date: Tue, 11 Nov 2025 15:36:44 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 14/14] cxl/region: Remove local variable @inc in
 cxl_port_setup_targets()
Message-ID: <20251111153644.000065bd@huawei.com>
In-Reply-To: <20251103184804.509762-15-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-15-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 3 Nov 2025 19:47:55 +0100
Robert Richter <rrichter@amd.com> wrote:

> Simplify the code by removing local variable @inc. The variable is not
> used elsewhere, remove it and directly increment the target number.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Hmm. I wonder what the thought process behind this once was? Ah well
clearly not needed now and I can't be bothered to do the archeology /
have too much other stuff to review!

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index dec003084521..a81fbe9cedae 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1332,7 +1332,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
> +	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
>  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -1524,9 +1524,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
>  		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
>  	}
> -	inc = 1;
> +	cxl_rr->nr_targets_set++;
>  out_target_set:
> -	cxl_rr->nr_targets_set += inc;
>  	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
>  		dev_name(port->uport_dev), dev_name(&port->dev),
>  		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),

