Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB1FC4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Nov 2022 22:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiKGWen (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Nov 2022 17:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKGWem (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Nov 2022 17:34:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC8CB4AA
        for <linux-cxl@vger.kernel.org>; Mon,  7 Nov 2022 14:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667860480; x=1699396480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tHr4J8z3pEPEgvZgRQBKNsHQLZGpXYp89ckMk8enDho=;
  b=bC0r6QFWP9oBFfTe3CeZ9WwXCvXr/lzlWN/B2NLD+TtG+F2sUN9vrTFN
   /pYATCOAX3iMi3T1phjaPESYdoriNLrd/xKGCvlnOYfrD+lJiipZc9M+N
   tUmpgDEQ+OqXZF/yGCYGPCp27JPYznDYruHq/PH0vxEM6KoDRDGOIwkPS
   mqAOr8HZJN2VJKH3KwAoE4oDubUzd4r6Tv9fDHNHO11/uhVSo9C0esOat
   o165kCnua72XiRZBuobuzOfX9Dl0a4Xpfw1MwKgyOyN6OgiUeroYf9kse
   Br5DX7T0WiktuT3hUOJH++hlJerTT4JTxbWsbJcCIzw80MeUTENYeoxqw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="337263189"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="337263189"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:34:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699666180"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="699666180"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.100.77])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:34:40 -0800
Date:   Mon, 7 Nov 2022 14:34:38 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     jonathan.cameron@huawei.com, mst@redhat.com, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] docs/cxl: Fix some typos
Message-ID: <Y2mH/jyY90uZv3cz@aschofie-mobl2>
References: <20221107180923.27072-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107180923.27072-1-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 07, 2022 at 10:09:23AM -0800, Davidlohr Bueso wrote:
> Found while reading the doc.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  docs/system/devices/cxl.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index abf7c1f24305..891bbd65d9d8 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -83,7 +83,7 @@ CXL Fixed Memory Windows (CFMW)
>  A CFMW consists of a particular range of Host Physical Address space
>  which is routed to particular CXL Host Bridges.  At time of generic
to 'a' particular

>  software initialization it will have a particularly interleaving
s/particularly/particular or just remove usage of the entire word
here and above. Not sure that 'particular'  is particularly helpful
here ;)

> -configuration and associated Quality of Serice Throtling Group (QTG).
> +configuration and associated Quality of Service Throttling Group (QTG).
>  This information is available to system software, when making
>  decisions about how to configure interleave across available CXL
>  memory devices.  It is provide as CFMW Structures (CFMWS) in

s/provide/provided


> @@ -98,7 +98,7 @@ specification defined register interface called CXL Host Bridge
>  Component Registers (CHBCR). The location of this CHBCR MMIO
>  space is described to system software via a CXL Host Bridge
>  Structure (CHBS) in the CEDT ACPI table.  The actual interfaces
> -are identical to those used for other parts of the CXL heirarchy
> +are identical to those used for other parts of the CXL hierarchy
>  as CXL Component Registers in PCI BARs.
>  
>  Interfaces provided include:
> @@ -111,7 +111,7 @@ Interfaces provided include:
>  
>  CXL Root Ports (CXL RP)
>  ~~~~~~~~~~~~~~~~~~~~~~~
> -A CXL Root Port servers te same purpose as a PCIe Root Port.
> +A CXL Root Port servers the same purpose as a PCIe Root Port.

s/servers/serves

>  There are a number of CXL specific Designated Vendor Specific
>  Extended Capabilities (DVSEC) in PCIe Configuration Space
>  and associated component register access via PCI bars.
> @@ -143,7 +143,7 @@ CXL Memory Devices - Type 3
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  CXL type 3 devices use a PCI class code and are intended to be supported
>  by a generic operating system driver. They have HDM decoders
> -though in these EP devices, the decoder is reponsible not for
> +though in these EP devices, the decoder is responsible not for

s/"responsible not"/"not responsible"

>  routing but for translation of the incoming host physical address (HPA)
>  into a Device Physical Address (DPA).
>  
> @@ -209,7 +209,7 @@ Notes:
>      ranges of the system physical address map.  Each CFMW has
>      particular interleave setup across the CXL Host Bridges (HB)
>      CFMW0 provides uninterleaved access to HB0, CFW2 provides
> -    uninterleaved acess to HB1. CFW1 provides interleaved memory access
> +    uninterleaved access to HB1. CFW1 provides interleaved memory access
>      across HB0 and HB1.

s/CFW1/CFMW1  s/CFW2/CFMW2

>  
>  (2) **Two CXL Host Bridges**. Each of these has 2 CXL Root Ports and
> @@ -282,7 +282,7 @@ Example topology involving a switch::
>              ---------------------------------------------------
>             |    Switch 0  USP as PCI 0d:00.0                   |
>             |    USP has HDM decoder which direct traffic to    |
> -           |    appropiate downstream port                     |
> +           |    appropriate downstream port                    |

to 'the' or to 'an' approp...

>             |    Switch BUS appears as 0e                       |
>             |x__________________________________________________|
>              |                  |               |              |

OK - after picking at this a bit, and only picking at the pieces
I see in this diff, I'll suggest a check back through this section
entirely, rather than the piecemeal spelling corrections.

Alison



> -- 
> 2.38.0
> 
