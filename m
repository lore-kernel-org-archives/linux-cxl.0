Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9872C04FDE
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Dec 2022 17:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLIROp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Dec 2022 12:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLIRO1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 9 Dec 2022 12:14:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE5526AA4
        for <linux-cxl@vger.kernel.org>; Fri,  9 Dec 2022 09:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670606039; x=1702142039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z7IE4fiXaS7oKlKyMlkL5FpaDU2NlOtji0Z/A0adz08=;
  b=i7JjMRnFj6r1SpKnd5T5sPzqLydVDPQjmtzPMe3KeOFzBC0kyqn7OhuU
   bkLaHHPYWtZhcOGDqczttLOXtmQxie/5DKTlPlb9c3QjPFAOuQ/T03Zl0
   tOpf5zRuXGK7FVyNmE7UYAQG6nJKLcjbwIs7FAJcR6zUEk18jqfzXoFUx
   0rP2ASM3U9cOJLgHGgtBIEr2TFA5Q+u8RzsmV9yLnPNu60UNgqQ7ZDvaT
   KvDa5Gxuci/U2kculVGokyCT+5zGnb532lY+bbxIo/tHGOktfN+F5RClc
   F91vW7BZ3i7vt8LTc7KVKcd04faO3aEiz6qbvIZ1ACPXgskqQ4lZ07XFK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="315142036"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="315142036"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 09:13:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="771918355"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="771918355"
Received: from xinjunwa-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.227.125])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 09:13:42 -0800
Date:   Fri, 9 Dec 2022 09:13:40 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        vishal.l.verma@intel.com, nvdimm@lists.linux.dev
Subject: Re: [ndctl PATCH v2 01/18] ndctl/test: Move firmware-update.sh to
 the 'destructive' set
Message-ID: <Y5NsxBeoL5nxSdAI@aschofie-mobl2>
References: <167053487710.582963.17616889985000817682.stgit@dwillia2-xfh.jf.intel.com>
 <167053488383.582963.12851797514973259163.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167053488383.582963.12851797514973259163.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Dec 08, 2022 at 01:28:03PM -0800, Dan Williams wrote:
> The firmware update test attempts a system-suspend test which may break
> systems that have a broken driver, or otherwise are not prepared to support
> suspend.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> Link: https://github.com/pmem/ndctl/issues/221
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  test/meson.build |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/test/meson.build b/test/meson.build
> index 5953c286d13f..c31d8eac66c5 100644
> --- a/test/meson.build
> +++ b/test/meson.build
> @@ -170,7 +170,6 @@ tests = [
>    [ 'btt-errors.sh',          btt_errors,	  'ndctl' ],
>    [ 'hugetlb',                hugetlb,		  'ndctl' ],
>    [ 'btt-pad-compat.sh',      btt_pad_compat,	  'ndctl' ],
> -  [ 'firmware-update.sh',     firmware_update,	  'ndctl' ],
>    [ 'ack-shutdown-count-set', ack_shutdown_count, 'ndctl' ],
>    [ 'rescan-partitions.sh',   rescan_partitions,  'ndctl' ],
>    [ 'inject-smart.sh',        inject_smart,	  'ndctl' ],
> @@ -196,6 +195,7 @@ if get_option('destructive').enabled()
>    mmap_test = find_program('mmap.sh')
>  
>    tests += [
> +    [ 'firmware-update.sh',     firmware_update,	  'ndctl' ],
>      [ 'pmem-ns',           pmem_ns,	   'ndctl' ],
>      [ 'sub-section.sh',    sub_section,	   'dax'   ],
>      [ 'dax-dev',           dax_dev,	   'dax'   ],
> 
