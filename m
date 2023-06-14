Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5411EB64DA
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jun 2023 09:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbjFNJPm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 05:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbjFNJPP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 05:15:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B35210A
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 02:15:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qh09b5sR9z6H7vP;
        Wed, 14 Jun 2023 17:14:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 10:15:09 +0100
Date:   Wed, 14 Jun 2023 10:15:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 06/19] cxl/hdm: Default CXL_DEVTYPE_DEVMEM decoders to
 CXL_DECODER_DEVMEM
Message-ID: <20230614101507.00006f03@Huawei.com>
In-Reply-To: <6488ee96ed0c_e067a2948a@dwillia2-xfh.jf.intel.com.notmuch>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592153054.1948938.12344684637653088842.stgit@dwillia2-xfh.jf.intel.com>
        <20230606122723.0000093d@Huawei.com>
        <6488ee96ed0c_e067a2948a@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 13 Jun 2023 15:32:54 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Sun, 04 Jun 2023 16:32:10 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > In preparation for device-memory region creation, arrange for decoders
> > > of CXL_DEVTYPE_DEVMEM memdevs to default to CXL_DECODER_DEVMEM for their
> > > target type.  
> > 
> > Why?  CXL_DEVTYPE_DEVMEM might just be a non CLASS code compliant HDM-H
> > only device.  I'd want those drivers to always set this explicitly.
> > 
> >   
> > > 
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/cxl/core/hdm.c |   14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index de8a3fb28331..ca3b99c6eacf 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -856,12 +856,22 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> > >  		}
> > >  		port->commit_end = cxld->id;
> > >  	} else {
> > > -		/* unless / until type-2 drivers arrive, assume type-3 */
> > >  		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
> > >  			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
> > >  			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));  
> > 
> > This is setting it to be HOSTMEM if it was previously DEVMEM and that
> > makes it inconsistent with the state cached below.
> > 
> > Not sure why it was conditional in the first place - writing to existing value
> > should have been safe and would be less code...  
> 
> folded in the following...
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> -- >8 --  
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 8deb362a7e44..715c1f103739 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -572,7 +572,7 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u32p_replace_bits(ctrl,
>  			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
> -			  CXL_HDM_DECODER0_CTRL_TYPE);
> +			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
>  }
>  
>  static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> @@ -840,7 +840,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		cxld->flags |= CXL_DECODER_F_ENABLE;
>  		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>  			cxld->flags |= CXL_DECODER_F_LOCK;
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
>  			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  		else
>  			cxld->target_type = CXL_DECODER_DEVMEM;
> @@ -859,14 +859,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		}
>  		port->commit_end = cxld->id;
>  	} else {
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
> -			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
> -			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
> -		}
>  		if (cxled) {
>  			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  			struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> +			/*
> +			 * Default by devtype until a device arrives that needs
> +			 * more precision.
> +			 */
>  			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
>  				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  			else
> @@ -875,6 +875,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			/* To be overridden by region type at commit time */
>  			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  		}
> +
> +		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) &&
> +		    cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
> +			ctrl |= CXL_HDM_DECODER0_CTRL_HOSTONLY;
> +			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
> +		}
>  	}
>  	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
>  			  &cxld->interleave_ways);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ae0965ac8c5a..f309b1387858 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -56,7 +56,7 @@
>  #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
>  #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
>  #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
> -#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
> +#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
>  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>  #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)

