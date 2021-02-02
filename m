Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC95C433E9
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2732664EDF
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhBBBCA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:02:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:21903 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhBBBB7 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:01:59 -0500
IronPort-SDR: YQ2TaCHQntGClKmUYUbo3efcH96hGMPiRIHYTnZYtAD7m5fx+p5eM4wJ2G7EYa7IkJVcannrxl
 H9sjxE1Id/UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294662"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294662"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:20 -0800
IronPort-SDR: szHpHkEB6C+oRtvKQRdrkrz1rx3RiRZtvYZYUqXU2QITVjCeoPVnHjhR+bLvtlLFJAFYGvUGrz
 jQx1egXaE6FQ==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764264"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:19 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     qemu-devel@nongnu.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH v3 26/31] tests/acpi: Add new CEDT files
Date:   Mon,  1 Feb 2021 16:59:43 -0800
Message-Id: <20210202005948.241655-27-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 tests/data/acpi/pc/CEDT                     | Bin 0 -> 36 bytes
 tests/data/acpi/q35/CEDT                    | Bin 0 -> 36 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/pc/CEDT b/tests/data/acpi/pc/CEDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..ebf9b54b0b27d9efca53359c3c2e560511f0e165 100644
GIT binary patch
literal 36
kcmZ>EbqP^nU|?X};N<V@5v<@85#a0$6k`O6f!H7#0Fb2z0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/CEDT b/tests/data/acpi/q35/CEDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..ebf9b54b0b27d9efca53359c3c2e560511f0e165 100644
GIT binary patch
literal 36
kcmZ>EbqP^nU|?X};N<V@5v<@85#a0$6k`O6f!H7#0Fb2z0RR91

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 9b07f1e1ff..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/CEDT",
-"tests/data/acpi/q35/CEDT",
-- 
2.30.0

