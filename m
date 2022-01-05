Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642B2C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Jan 2022 21:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244528AbiAEVf3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:35:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:16459 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244519AbiAEVfF (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 5 Jan 2022 16:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641418504; x=1672954504;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nCAaItum+5HppG++YWpzN72ImzToj0lcy7j7tv0h9UU=;
  b=XhEekTivjbngi6K3q/tcPVK9+Ai3IaUv6IBg2eQy6zA6Xxmii3xCG46t
   j2nD/CgqK9KKiVLwg0rOri99ddYmCnN6ADjbNfL9sIgk/pM1VIwFeTFKp
   xH9oWMcWBWiAPgkycDFn55alJfphTGGHv3p2MJqSwpR6jFUl5cJMygtic
   p7GOzZ2heULcqjE2G+CO798lnQCsj6qAexpL93vKWHLgELNkKPRq4+bnz
   CnHf4QJ9IM1DOx1xwHtj+bxV38xa2gSw15YIcS/PDsJAIYWT5zgpip5jf
   hslXC3A9E0GIM///oPwGe0Uh7dnxY2zeJgL2YQNzlMTC592le4baYFD2j
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229354124"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="229354124"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="668240795"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:48 -0800
Subject: [ndctl PATCH v3 13/16] ndctl: Drop executable bit for
 bash-completion script
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Wed, 05 Jan 2022 13:32:47 -0800
Message-ID: <164141836772.3990253.4996882214531720931.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The rpm build process warns:

*** WARNING: ./usr/share/bash-completion/completions/ndctl is executable but has no shebang, removing executable bit

Clear the unnecessary executable bit since completion helpers are sourced,
not executed.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 contrib/ndctl |    0 
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 contrib/ndctl

diff --git a/contrib/ndctl b/contrib/ndctl
old mode 100755
new mode 100644

