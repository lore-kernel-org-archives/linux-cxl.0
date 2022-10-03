Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C95C433FE
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Oct 2022 23:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiJCXXV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Oct 2022 19:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJCXXU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 3 Oct 2022 19:23:20 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1D1A237
        for <linux-cxl@vger.kernel.org>; Mon,  3 Oct 2022 16:23:17 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293N6Rac011143
        for <linux-cxl@vger.kernel.org>; Mon, 3 Oct 2022 16:23:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=BVNB1CSGPqp7yQ/MNwhtTDcx7lLXpyyoJFUDXAGE4GE=;
 b=JjYWNarYTMfvuRkpe5CJsA4hsjbp2DlEO5sbgPBqodoXsS+5/fUizTppnt3YQAKch8vk
 0cfHEsQLuRziwPB2WKqJdxV3eKJLSvHXu2lV83Nb5WJ3TJcv/ccUl9NmOoQld4QZUOTM
 Y1bY0X/+zW910nHjX4HHQ2++IItRh+GDTr4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jxk30e44t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Mon, 03 Oct 2022 16:23:15 -0700
Received: from twshared3307.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 16:23:14 -0700
Received: by devvm7073.vll0.facebook.com (Postfix, from userid 175343)
        id 99F0A12CA3CE; Mon,  3 Oct 2022 16:23:11 -0700 (PDT)
From:   Jonathan Zhang <jonzhang@fb.com>
To:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <wzhang@meta.com>
CC:     Jonathan Zhang <jonzhang@meta.com>
Subject: [ndctl PATCH 0/2] add support for CCI command Get Alert Configuration
Date:   Mon, 3 Oct 2022 16:23:04 -0700
Message-ID: <20221003232306.1326511-1-jonzhang@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: I3f29_fnQDCjL3iP1i0uyjDbTnjrfsZL
X-Proofpoint-ORIG-GUID: I3f29_fnQDCjL3iP1i0uyjDbTnjrfsZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Zhang <jonzhang@meta.com>

CXL spec 3.0 section 8.2.9.8.3.2 defines CCI command
Get Alert Configuration.

This patchset adds support for it.

Jonathan Zhang (2):
  libcxl: add accessors for Get Alert Configuration CCI command output
  cxl: display alert configuratin fields in list command

 Documentation/cxl/cxl-list.txt   |  33 ++++++++
 Documentation/cxl/lib/libcxl.txt |   1 +
 cxl/filter.c                     |   2 +
 cxl/filter.h                     |   1 +
 cxl/json.c                       | 131 +++++++++++++++++++++++++++++++
 cxl/lib/libcxl.c                 | 120 ++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |  23 ++++++
 cxl/lib/private.h                |  28 +++++++
 cxl/libcxl.h                     |  19 +++++
 cxl/list.c                       |   3 +
 util/json.h                      |   1 +
 11 files changed, 362 insertions(+)

--=20
2.30.2

