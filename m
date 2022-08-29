Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5947AC0502E
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Aug 2022 23:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiH2XmF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Aug 2022 19:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH2XmE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 29 Aug 2022 19:42:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9648992B
        for <linux-cxl@vger.kernel.org>; Mon, 29 Aug 2022 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661816522; x=1693352522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s9heJNo7hY6As6AqNo0+xd/BvLwH0HJGS32GiosR7m0=;
  b=alh3eaCwUw/JYiIAZSXKFiICtSN7Vw+S8PhvVocV4LmvW+LVoYLU8l8f
   YYV1MITxhfrRkdEfqmTXRinZ8GAuOXYHVukdPKSN1C3G/f10mhRY060P3
   64aUw3MS30O9xaBR1S5ZJf3AA8jvswg4q4uH//EWlmjKjF/2WJoHYGv+t
   c3UNTea48AOo3erYtATDKRIVtB+OtkcdCUMesBf47M8aoPlKhXdOY1Iip
   YhcHEb/8pgU8KDPt5Se9+Oe+qNItNk7VVEyzXwvoOqKk4R5U7SU5UJS2S
   r9talQFjoR4rsXY3dnlNlduBVUtH83HXZb4gt3nmDxMQuG/eN2Xb/+zY4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="321150957"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="321150957"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 16:42:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="588358109"
Received: from kmora1-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.213.169.48])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 16:42:00 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <nvdimm@lists.linux.dev>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        corsepiu@fedoraproject.org, <linux-cxl@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 1/2] ndctl.spec.in: Address misc. packaging bugs (RHBZ#2100157)
Date:   Mon, 29 Aug 2022 17:41:56 -0600
Message-Id: <20220829234157.101085-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829234157.101085-1-vishal.l.verma@intel.com>
References: <20220829234157.101085-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; h=from:subject; bh=s9heJNo7hY6As6AqNo0+xd/BvLwH0HJGS32GiosR7m0=; b=owGbwMvMwCXGf25diOft7jLG02pJDMm8fkc5Q2etOSv4pY+Du8H7nN6JqkR9G5m/kbyJvunfq9T8 JBd0lLIwiHExyIopsvzd85HxmNz2fJ7ABEeYOaxMIEMYuDgFYCJeAgz/o9LD29lnrf5zzlLcYNGB64 eVdJe+PbIu+tC3Z7eesHz9FMLwPy7lZGFQjPaXvws67qxzzDpSfyn3E/vttRrnHj5crXThEjsA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Address some RPM packing bugs where the spec failed to claim parent
directories that it creates for config files.

Based on a patch by Ralf Corsépius <corsepiu@fedoraproject.org>

Link: https://src.fedoraproject.org/rpms/ndctl/c/401f506f1288384127e1ca20c64df64a9cd413f2?branch=rawhide
Cc: Ralf Corsépius <corsepiu@fedoraproject.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl.spec.in | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ndctl.spec.in b/ndctl.spec.in
index cfcafa2..4788dab 100644
--- a/ndctl.spec.in
+++ b/ndctl.spec.in
@@ -171,9 +171,14 @@ fi
 %{_mandir}/man1/ndctl*
 %{bashcompdir}/ndctl
 %{_unitdir}/ndctl-monitor.service
+
+%dir %{_sysconfdir}/ndctl
+%dir %{_sysconfdir}/ndctl/keys
 %{_sysconfdir}/ndctl/keys/keys.readme
+
 %{_sysconfdir}/modprobe.d/nvdimm-security.conf
 
+%dir %{_sysconfdir}/ndctl.conf.d
 %config(noreplace) %{_sysconfdir}/ndctl.conf.d/monitor.conf
 %config(noreplace) %{_sysconfdir}/ndctl.conf.d/ndctl.conf
 
@@ -182,10 +187,11 @@ fi
 %license LICENSES/preferred/GPL-2.0 LICENSES/other/MIT LICENSES/other/CC0-1.0
 %{_bindir}/daxctl
 %{_mandir}/man1/daxctl*
-%{_datadir}/daxctl/daxctl.conf
+%{_datadir}/daxctl
 %{bashcompdir}/daxctl
 %{_unitdir}/daxdev-reconfigure@.service
 %config %{_udevrulesdir}/90-daxctl-device.rules
+%dir %{_sysconfdir}/daxctl.conf.d/
 %config(noreplace) %{_sysconfdir}/daxctl.conf.d/daxctl.example.conf
 
 %files -n cxl-cli
-- 
2.37.2

