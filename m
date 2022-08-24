Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECBEC32793
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 00:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiHXAET (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 Aug 2022 20:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiHXAES (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 Aug 2022 20:04:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC89895CB
        for <linux-cxl@vger.kernel.org>; Tue, 23 Aug 2022 17:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661299457; x=1692835457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mxd+7YmgTj1JAjvIY/neHCAi/vcL4X0sAIVDfYHJegw=;
  b=Y8zBSmdjFjCMGm0UuaKdeJftpRxTYMVXCsMMEJUxGOFquTEwcy5kc8m1
   AVt+thFppdBnSOO+of2yfgwFSvtyrQHzotyJKhmxO5jMbYEBfIyMNWX0t
   E+Y359r4m41Qe5LkLclpYwYgqOVaURceiPbuaCrfIJhvbXTC2xNP9tWfS
   lPol+p855nTxmluu6FthXzRZq++0sWwgtvOAojE9omDV/O7lbc1r8IG4G
   U5m5dZY+YHOisk4KTAT1G5kVKyTt24+EH9wxrgoRQGrJ8G1lsfi3QGY2T
   jlgynAsDlzGifLDov3iJSq7KdDUpy0XlbSUJvOP8n69Bid5VN3kIV54XQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="295108239"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="295108239"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 17:04:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="612593142"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.86.80]) ([10.212.86.80])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 17:04:16 -0700
Message-ID: <fab208dd-e6c5-417a-53e8-5eb2d91bd587@intel.com>
Date:   Tue, 23 Aug 2022 17:04:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [ndctl PATCH v2 3/3] cxl/filter: Fix an uninitialized pointer
 dereference
Content-Language: en-US
To:     Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>
References: <20220823074527.404435-1-vishal.l.verma@intel.com>
 <20220823074527.404435-4-vishal.l.verma@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220823074527.404435-4-vishal.l.verma@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 8/23/2022 12:45 AM, Vishal Verma wrote:
> Static analysis points out that there was a chance that 'jdecoder' could
> be used while uninitialized in walk_decoders(). Initialize it to NULL to
> avoid this.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   cxl/filter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cxl/filter.c b/cxl/filter.c
> index 9a3de8c..56c6599 100644
> --- a/cxl/filter.c
> +++ b/cxl/filter.c
> @@ -796,7 +796,7 @@ static void walk_decoders(struct cxl_port *port, struct cxl_filter_params *p,
>   	cxl_decoder_foreach(port, decoder) {
>   		const char *devname = cxl_decoder_get_devname(decoder);
>   		struct json_object *jchildregions = NULL;
> -		struct json_object *jdecoder;
> +		struct json_object *jdecoder = NULL;
>   
>   		if (!p->decoders)
>   			goto walk_children;
