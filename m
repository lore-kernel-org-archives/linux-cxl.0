Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D01C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Jan 2022 22:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiAGWkH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:40:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:41935 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbiAGWkH (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 7 Jan 2022 17:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641595207; x=1673131207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMKk14UvD9zwnkh1jlI91c3SZkZ4wKA/Xjs/3pmTV3Q=;
  b=hb7/nPk0akwJ5UBTtPTSJSZwSAByzcowqSoKAcwuuMpCf81p+T09/Npn
   5mQxPKYIyg3bqki29LhBa660MOLRNxgkhZKcdouT9bqibvROsDj6v8vP/
   68HyfkVntp5JXIbE37pNa5l2s2/n1W15P4zTxCJThEx0UszSuN0Z0+Tqo
   X4QVfAaImK8l7zmFerccSsCpPVkvcDC5ys4VCNxomXY+V9nXVPTJcN4OE
   819Qnq5dSYvdyGIBAwINLPPaVIgol/vQDHQ/CiQcagkuY55+6MIM9QSEI
   fAP2+kI4YXIdQ0CYyxxadBXjhiDWG8KmtH4Y3qLGiiwJMIdURnPFDKixN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242754173"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="242754173"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:40:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="668906135"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:40:06 -0800
Date:   Fri, 7 Jan 2022 14:45:15 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH 7/7] cxl: add command set-partition-info
Message-ID: <20220107224515.GA804232@alison-desk>
References: <cover.1641233076.git.alison.schofield@intel.com>
 <fd590fbbc2f1abaeca1fd368d26c4e90c3a89d69.1641233076.git.alison.schofield@intel.com>
 <CAPcyv4gYjDo7vuFYqJgUL6mvOKosrzLRMxTA8tB0v86s08f_VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gYjDo7vuFYqJgUL6mvOKosrzLRMxTA8tB0v86s08f_VA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 06, 2022 at 02:19:08PM -0800, Dan Williams wrote:
> On Mon, Jan 3, 2022 at 12:11 PM <alison.schofield@intel.com> wrote:
> >

snip

> 
> One of the conventions from ndctl is that any command that modifies an
> object should also emit the updated state of that object in JSON. For
> example, "ndctl reconfigure-namespace" arranges for:
> 
>                 unsigned long flags = UTIL_JSON_DAX | UTIL_JSON_DAX_DEVS;
>                 struct json_object *jndns;
> 
>                 if (isatty(1))
>                         flags |= UTIL_JSON_HUMAN;
>                 jndns = util_namespace_to_json(ndns, flags);
>                 if (jndns)
>                         printf("%s\n", json_object_to_json_string_ext(jndns,
>                                                 JSON_C_TO_STRING_PRETTY));
> 
> ...to dump the updated state of the namespace, so a similar
> util_memdev_to_json() seems appropriate here. However, perhaps that
> can come later. I have work-in-progress patches to move the core of
> cxl/list.c to a cxl_filter_walk() helper that would allow you to just
> call that to dump a listing for all the memdevs that were passed on
> the command line.

Will add. Thanks!
