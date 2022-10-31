Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE80DECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Oct 2022 23:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJaXzC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJaXzB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Oct 2022 19:55:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1BC12AB8
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 16:55:00 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29VMPIkl007806
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 16:54:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=WQto1nO13KpgIdPoT5NWGtaPQ6Geuxp1XtBZm+QC0bk=;
 b=YZ4IdTNYnonZCVuJhE9P6eirg53CJHARSfaCwcOXxLHGMVZnwesp+mdLwPCnMiRu+wRK
 oT23nosyoVdgKSrYZcvohtp6PrfmMi66XupO3/TgJgP5HCmp8bm3AHtKP/XOUAXdief2
 YtwtJx8euqiDIlKMpXKXUFvTyfYgB5efAjhQhSXWxtWkL4IijzUHeqBCv9rH3H80crMO
 3TUHwdOPCUn5rrRvfH8340dDPUcWyVsRqGD1C53O5tPOAZ4fhVS4+OgCtKb6kZgxvYPK
 tDjtS/Q3WQoGnBAo3gajk9luwbHG7W16YSqAYGFkiFzAteZiqfY+0IdyfdEw5o1UryX5 VQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kgyux4keg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 16:54:59 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 16:54:58 -0700
Received: by devvm7073.vll0.facebook.com (Postfix, from userid 175343)
        id AD17A29EC75B; Mon, 31 Oct 2022 16:54:52 -0700 (PDT)
From:   Jonathan Zhang <jonzhang@meta.com>
To:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <wzhang@meta.com>, <alison.schofield@intel.com>
CC:     Jonathan Zhang <jonzhang@meta.com>
Subject: [ndctl PATCH V3 0/2] add support for CCI Get Alert Configuration
Date:   Mon, 31 Oct 2022 16:54:48 -0700
Message-ID: <20221031235450.1775068-1-jonzhang@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: b1ot63xH__iLDFnHSyPNElKFIbkH4SXB
X-Proofpoint-GUID: b1ot63xH__iLDFnHSyPNElKFIbkH4SXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL spec 3.0 section 8.2.9.8.3.2 defines CCI command
Get Alert Configuration.

This patchset adds support for it.
 =20
v3:
- Update man page and JSON output to use "alert-config" (Alison).

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

