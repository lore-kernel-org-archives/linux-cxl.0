Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD48C19F2D
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 17:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245092AbiHIRIw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 13:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245222AbiHIRIv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 13:08:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2E124BD0
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660064930; x=1691600930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0a8OPBbfu1COE5iarG9OcVDY304F/Cpqx/A+vDeL/4c=;
  b=djioJQVzePhTW4ioqUIK0QVagzJmLB4a2MCvClX1WoQ22o5LrX0wJuLH
   RQdRgOubMnjnZy78SqczZRrb+4H7YCYnNqQfNwAgaEQSCJ20z51H4Zo4i
   d/TYeCjfTg6kiGXYKNVpZQDmGRshdBkmedi7jcwWfXCex52Fn1eFmDlIP
   KMI1mnfZsjJeGGXnsUiyS272LQk32at1rwL3i39hJ15SBS45mtNGGBhbv
   jRBn/QYdVBRhrr33cg+YVT5qTdv3w7K4r2vjahCztrQGr9EPzAfJN9QWS
   h2kI1qihyth6UY5dED9rhC+4M7vtCpLC9OlthuiHSWu+fMHh/jCdtw/JK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="316825640"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="316825640"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 10:08:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="633407195"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 10:08:47 -0700
Date:   Tue, 9 Aug 2022 10:06:30 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/3] cxl: Add check for result of interleave ways plus
 granularity combo
Message-ID: <20220809170630.GA1756195@alison-desk>
References: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
 <165999281717.493131.1159254270127915425.stgit@djiang5-desk4.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165999281717.493131.1159254270127915425.stgit@djiang5-desk4.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave - Haven't reviewed yet, but wanted to drop this tidbit - 

On Mon, Aug 08, 2022 at 02:06:57PM -0700, Dave Jiang wrote:
> Add a helper function to check the combination of interleave ways and
> interleave granularity together is sane against the interleave mask from
> the HDM decoder. Add the check to cxl_region_attach() to make sure the
> region config is sane. Add the check to cxl_port_setup_targets() to make
> sure the port setup config is also sane.
> 
> Calculation refers to CXL spec v3 8.2.4.19.13 implementation note #3.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

snip

> +static inline int cxl_interleave_verify(struct cxl_port *port,
> +					int ways, int granularity)
> +{
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	unsigned int addr_mask;
> +	u16 ig;
> +	u8 iw;

s/ig/eig
s/iw/eiw
For consistency, let's use the "e" version of these names to mean
encoded value.  

> +	int rc;
> +
> +	rc = granularity_to_cxl(granularity, &ig);
> +	if (rc)
> +		return rc;
> +
> +	rc = ways_to_cxl(ways, &iw);
> +	if (rc)
> +		return rc;
> +
> +	if (iw == 0)
> +		return 0;
> +
> +	if (iw < CXL_INTERLEAVE_3_WAY)
> +		addr_mask = GENMASK(ig + 8 + iw - 1, ig + 8);
> +	else
> +		addr_mask = GENMASK((ig + iw) / 3 - 1, ig + 8);
> +
> +	if (~cxlhdm->interleave_mask & addr_mask)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  struct seq_file;
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
> 
> 
