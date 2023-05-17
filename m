Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F735C77B7D
	for <linux-cxl@archiver.kernel.org>; Wed, 17 May 2023 03:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjEQDXu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 23:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjEQDXs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 23:23:48 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA88C10E9
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 20:23:44 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230517032340epoutp030dcd0853fdef34d8b18c3d2e2965bc90~f0E5pb4TI1330813308epoutp03O
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 03:23:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230517032340epoutp030dcd0853fdef34d8b18c3d2e2965bc90~f0E5pb4TI1330813308epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684293820;
        bh=h1P4gIJg0sg4h71mZ5fxszVfS4sKPXy2Yrp+UGnsXTo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=d+eKuDakOT4rOD2oIjJL86V7gFPRBOw/zePfdE6fkc6m1o1N/hCTCj8AHrzdsBpab
         nNybHoVUN9tqhlLt0NP+yyyJiX5zc5yr+pdxFJJLhE5iQPaSvhppQ+dw2xer696aWY
         BtWMbCrFpiEeJwVpuEJUi68vBEPmiDlfDP3XUgAw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230517032340epcas2p19672162476909e36f437cac01af4e96f~f0E5Icirv1976219762epcas2p14;
        Wed, 17 May 2023 03:23:40 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QLdjl5Nq7z4x9Pw; Wed, 17 May
        2023 03:23:39 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.8A.03265.BB844646; Wed, 17 May 2023 12:23:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230517032339epcas2p37c7d1dcd8a057f2c2ddd72c4b476d0ab~f0E4N3lzO0983209832epcas2p3e;
        Wed, 17 May 2023 03:23:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230517032339epsmtrp2708e58f47da419b078e1c22bd245b81c~f0E4NJ2FT0097500975epsmtrp2B;
        Wed, 17 May 2023 03:23:39 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-ef-646448bbd544
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.74.28392.BB844646; Wed, 17 May 2023 12:23:39 +0900 (KST)
Received: from dell-ArcherCity.dsn.sec.samsung.com (unknown [10.229.83.212])
        by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230517032339epsmtip21e45757e576b71f5dfb5f897cdda4293~f0E38Dfdl1034810348epsmtip2O;
        Wed, 17 May 2023 03:23:39 +0000 (GMT)
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, dan.j.williams@intel.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        ira.weiny@intel.com, ks0204.kim@samsung.com,
        Junhyeok Im <junhyeok.im@samsung.com>
Subject: [ndctl PATCH v2 0/2] Support for inject and clear poison
Date:   Wed, 17 May 2023 12:23:09 +0900
Message-Id: <20230517032311.19923-1-junhyeok.im@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmqe5uj5QUgynv1C3uPr7AZtE8eTGj
        xfSpFxgt9j99zmKx+OgMZoujezgszs86xWJxa8IxJgcOj8V7XjJ5bFrVyebRt2UVo8fnTXIB
        LFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoT
        sjPuXfnEXPCCq+Lty+vsDYwf2bsYOTkkBEwketZcZuxi5OIQEtjBKHH5/wo2COcTkLP7IVTm
        M6NE581VrDAt+//fYIZI7GKUaLkylRXCaWSS2P7qElgVm4C2xN/+6YwgtoiArETzugdMIEXM
        AvsZJVbs3MIGkhAWcJRoXNYPdgmLgKpE64RLTCA2r4CNxNkFF5kg1slL7D94lhkiLihxcuYT
        FhCbGSjevHU22BkSAqfYJR7u+A40lAPIcZHYuDkSoldY4tXxLVCfSkl8freXDcLOl5h6cCJU
        vESi7cwBKNtY4t3N56wgY5gFNCXW79KHmKgsceQW1FY+iY7Df9khwrwSHW1CEI2qEls2vIAa
        Ii1xdOImFgjbQ+JV61JwKAgJxEp8azjJOoFRfhaSX2Yh+WUWwt4FjMyrGMVSC4pz01OLjQoM
        4ZGanJ+7iRGcELVcdzBOfvtB7xAjEwfjIUYJDmYlEd7AvuQUId6UxMqq1KL8+KLSnNTiQ4ym
        wNCdyCwlmpwPTMl5JfGGJpYGJmZmhuZGpgbmSuK80rYnk4UE0hNLUrNTUwtSi2D6mDg4pRqY
        wrKObCja81/7hV5gaOvd+JaE7Sd4XrOmd0XF3JywpHbpqdeTL3jKHRP+EHTnoNCcPz++HPx4
        7brz//8pb0pC5yd+7NsRtOyoNHfgmWtJrwWin9faRxfcT6pbc8uyW2oNe3pD1sb9u9YHpQj4
        lB1a6Wsy6ezs8h8T18nWLrzGPr3se/2OdMPFgme9SnsFJ57V+5i7trxhQtirpx7CJ5ZP6loW
        bf9qTejejdV/lZkX7d9jKjbN99qOfdohV++qNTAu1pVs6fOtyT1TeHpugPpb2eTuo4Ffd6/Q
        4X6itcD9SPIRdSHT0qqzs3/sYFLPvnRgiqHvpUncPQtl0n9MP/QrueRvptMxjpygg0KpH9oe
        flNiKc5INNRiLipOBABkcEPXEQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO5uj5QUg02T2S3uPr7AZtE8eTGj
        xfSpFxgt9j99zmKx+OgMZoujezgszs86xWJxa8IxJgcOj8V7XjJ5bFrVyebRt2UVo8fnTXIB
        LFFcNimpOZllqUX6dglcGfeufGIueMFV8fbldfYGxo/sXYycHBICJhL7/99g7mLk4hAS2MEo
        sfXtFSaIhLTEjUddbBC2sMT9liOsEEX/GSWuH9rFCJJgE9CW+Ns/HcwWEZCVaF73gAmkiFng
        OKPEjf0QRcICjhKNy/rB1rEIqEq0TrgEtoFXwEbi7IKLUNvkJfYfPMsMEReUODnzCQuIzQwU
        b946m3kCI98sJKlZSFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEh6mW1g7G
        Pas+6B1iZOJgPMQowcGsJMIb2JecIsSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS
        1OzU1ILUIpgsEwenVAOTI8vaTr/79XJZ9e/CpnSHb9+0aPKJHm8dgTdqd96xvjka/iT4DMNm
        lYbfapWrFm74zpXY+K3Ht3eOg+w3qbSg+aGLN27R7l0VEPb7Q+AEn/9vG5Oa/ypsEPiXfs+F
        N+vctWVxKidF1oay7nt52rbNbtbWlUpzvk2dabZz82WRUwejlC70a9wV4v66jWH71ujX+95f
        5ni+2uBL/4bekLIHjkf3NRpztPL/qij19r957tdPa5FQHu6iP3zvjk9bIDvr8F1BvZPLHV12
        haZZ/lqyQo7VJ2Gv/YzG8zZt99Y/9dN2/vqiunlDcNLB+bOtJQXSfO0Kph9On+bNFlI622Hb
        xNPJ7tsaYo5180zVj7rCoMRSnJFoqMVcVJwIAP9OQyPCAgAA
X-CMS-MailID: 20230517032339epcas2p37c7d1dcd8a057f2c2ddd72c4b476d0ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230517032339epcas2p37c7d1dcd8a057f2c2ddd72c4b476d0ab
References: <CGME20230517032339epcas2p37c7d1dcd8a057f2c2ddd72c4b476d0ab@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This series adds new abilities to inject and clear poison, including library
updates and new commands interface(inject-poison, clear-poison).

Changes in v2:
- added clear poison support.
- changed from sysfs to debugfs attribute to write DPA, according to cxl
kernel update.
- Integrated doc changes and code changes into a single patch.

Link to v1:
https://lore.kernel.org/linux-cxl/20230220045709.94027-1-junhyeok.im@samsung.com/


Junhyeok Im (2):
  libcxl: Add memdev inject & clear poison support
  cxl: add inject-poison & clear-poison commands to cxl tool

 Documentation/cxl/cxl-clear-poison.txt  | 41 ++++++++++++
 Documentation/cxl/cxl-inject-poison.txt | 42 ++++++++++++
 Documentation/cxl/lib/libcxl.txt        |  5 ++
 Documentation/cxl/meson.build           |  2 +
 cxl/builtin.h                           |  2 +
 cxl/cxl.c                               |  2 +
 cxl/lib/libcxl.c                        | 53 +++++++++++++++
 cxl/lib/libcxl.sym                      |  6 ++
 cxl/libcxl.h                            |  2 +
 cxl/memdev.c                            | 85 ++++++++++++++++++++++++-
 10 files changed, 237 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/cxl/cxl-clear-poison.txt
 create mode 100644 Documentation/cxl/cxl-inject-poison.txt


base-commit: 26e81cc4d57cdcebc86e41bf1854d863c3fa8112
-- 
2.34.1

