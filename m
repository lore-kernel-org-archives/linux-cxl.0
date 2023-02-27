Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C89C6FA8E
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 02:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjB0Cl7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 26 Feb 2023 21:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjB0Clm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 26 Feb 2023 21:41:42 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9B81BACF
        for <linux-cxl@vger.kernel.org>; Sun, 26 Feb 2023 18:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677465667; x=1709001667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XWLf/MBUUm8z4Zdco0M459fJtOGxSj1LF0MezLxjSxo=;
  b=NwihHUwxQo2BKBmmuFFt+D1iuRYk9fgIiqiXaloU9a/JQJuPuQQsxgoP
   MZ3iZy1ZmSwSze8WhchlJK7BOYYaZ0EmPeAE2D49UL72/v+gSj3iyyj9d
   OIW7HUOVa9FOxMS0/BkOpnw2pVq7HqR7C9xvH+OCQp7l8Up6+MlVsEF6d
   Y1AM0Iy6/8x51j6HQMoPzUTQmqzspZ91qaE4QHEGUnt7MWahfx8e//HDg
   f5XkAmE7rVw7yBJfE/O+G03FLaGyrtx/9K1EiFIM2MhTVavpszf8XGpD9
   nJ2j77EUHiDX7HaR6l1xbkIHkFYXQ77nRnFWWzu9mp7pG4CnJ9ZLTkTlg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="317565636"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="317565636"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 18:38:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="705967563"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="705967563"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.83.169])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 18:38:22 -0800
Date:   Sun, 26 Feb 2023 18:38:21 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Junhyeok Im <junhyeok.im@samsung.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org
Subject: Re: [ndctl 0/3] Support for inject poison
Message-ID: <Y/wXnZjhplI9AUvv@aschofie-mobl2>
References: <CGME20230220045604epcas2p3bc0b1fb688c48ec0b8ae2512adba3513@epcas2p3.samsung.com>
 <20230220045709.94027-1-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220045709.94027-1-junhyeok.im@samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 20, 2023 at 01:57:06PM +0900, Junhyeok Im wrote:
> This series adds new ability to inject poison, including library update
> and new command interface(inject-poison).

Hi Junhyeok,
Nice to see this set, and sorry for the delay in trying it out. I'm
using it now while prepping another version of the driver support 
for inject and clear.

> 
> Junhyeok Im (3):
>   libcxl: add memdev inject poison support
>   cxl: add inject-poison command to cxl tool
>   Documentation: add man page documentation for inject-poison

The libcxl.sym and libclx.txt changes in the 3rd patch go better
in the 1st patch that adds the libcxl support.

> 
>  Documentation/cxl/cxl-inject-poison.txt | 42 ++++++++++++++++++++
>  Documentation/cxl/lib/libcxl.txt        |  4 ++
>  Documentation/cxl/meson.build           |  1 +
>  cxl/builtin.h                           |  1 +
>  cxl/cxl.c                               |  1 +
>  cxl/lib/libcxl.c                        | 26 ++++++++++++
>  cxl/lib/libcxl.sym                      |  5 +++
>  cxl/libcxl.h                            |  1 +
>  cxl/memdev.c                            | 53 +++++++++++++++++++++++--
>  9 files changed, 131 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/cxl/cxl-inject-poison.txt
> 
> 
> base-commit: a88bdcfb4202c73aadfee6f83c5502eb5121cbd9
> -- 
> 2.34.1
> 
