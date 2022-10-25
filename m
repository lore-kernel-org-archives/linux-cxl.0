Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAB7FA373E
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 20:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJYUnj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 16:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiJYUni (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 16:43:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D956D11CB46
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 13:43:37 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29PJjhGl021803
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 13:43:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=f2XprlFx+zvinltkltJX88CSLcfeB/43dGPS24YOaas=;
 b=NOc01Vj8efHPE/5yGcqSMz9ruStKh+a+0KbWcHPa9UXWkFNB8pq/Gk2ghDmDToyNM3A/
 BZCkf9H7QhS6MwfSuyJsY8ExSpidG+w1vN3uxcnIO9o14U/uvJBaRZ8l80QNlH6Jv8vH
 hNS+TgzUw2NSQHYUy/A4RWCp/hRPfd8jJLRJhY/ioMeUKKmmaeAKRInQ4yvd3qhVsB6P
 6lte+5pzGxvTmZFr2tE4i1ufqN5fASkTVSH5BoZIk/f8Nun7kLIRW08+XplLsFvw4PMf
 zmyk+veCzgQLe7MeCSy98zO0bzt/rrq027OgG+fVvP0NsWn88SD7bC9n4LuADFG4y2at ig== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ke9ydgpdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 13:43:37 -0700
Received: from twshared13931.24.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 13:43:36 -0700
Received: by devvm7073.vll0.facebook.com (Postfix, from userid 175343)
        id 9D95E24C5BF1; Tue, 25 Oct 2022 13:43:29 -0700 (PDT)
From:   Jonathan Zhang <jonzhang@meta.com>
To:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <wzhang@meta.com>
CC:     Jonathan Zhang <jonzhang@meta.com>
Subject: [ndctl PATCH V2 0/2] add support for CCI Get Alert Configuration
Date:   Tue, 25 Oct 2022 13:43:18 -0700
Message-ID: <20221025204320.290354-1-jonzhang@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aDoETZpL-X1BM9JX1Mc3wMtNMjXeo8yg
X-Proofpoint-GUID: aDoETZpL-X1BM9JX1Mc3wMtNMjXeo8yg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_13,2022-10-25_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL spec 3.0 section 8.2.9.8.3.2 defines CCI command
Get Alert Configuration.

This patchset adds support for it.

v2:
- Change the command parameter from "alert" to "alert-config" (Vishal).
- Update the format based on clang-formt (Vishal).
- Updated the names to be consistent with the existing code (Vishal). Suc=
h as:
-- pers_mem --> pmem
-- temp --> temperature
-- drop "get_" from some function names.

Jonathan Zhang (2):
  libcxl: add accessors for Get Alert Configuration CCI output
  cxl: display alert configuration fields in list command

 Documentation/cxl/cxl-list.txt   |  33 ++++++
 Documentation/cxl/lib/libcxl.txt |   1 +
 cxl/filter.c                     |   2 +
 cxl/filter.h                     |   1 +
 cxl/json.c                       | 185 +++++++++++++++++++++++++++++++
 cxl/lib/libcxl.c                 | 163 +++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |  23 ++++
 cxl/lib/private.h                |  38 +++++++
 cxl/libcxl.h                     |  35 ++++++
 cxl/list.c                       |   6 +-
 util/json.h                      |   1 +
 11 files changed, 486 insertions(+), 2 deletions(-)

--=20
2.30.2

