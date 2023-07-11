Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64AEEB64DC
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Jul 2023 07:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGKHII (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Jul 2023 03:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGKHIH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Jul 2023 03:08:07 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4E4B1
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 00:08:05 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230711070800epoutp018b48d15266c109fc51c27159ea0adca5~wvnduFE0X1541915419epoutp01X
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 07:08:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230711070800epoutp018b48d15266c109fc51c27159ea0adca5~wvnduFE0X1541915419epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689059280;
        bh=jmfrpSvGrQEfRxZn49TEj1fGT89kP9nwXGc2KktOdng=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tM8kX3vxQ5NEY3uXoG5KtZo1dcilN3slx5CTTwIZ0qgPbTF0+odndtxO2p46hlKIX
         zLiiL6OXylTXeYKLSReUfokWxWw1g0UBvnk5FPb1n6YS2ZgUJF1djRGcJ6UwLihVnL
         S1UUxpkqCap42NvCDdY3mLG7Q/mH0t9+7PJJe/eQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230711070759epcas2p3d65eb95de2e0576ba5eb6a7e39b7791e~wvndIgXZJ2574425744epcas2p3W;
        Tue, 11 Jul 2023 07:07:59 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R0X5C1l1Fz4x9QD; Tue, 11 Jul
        2023 07:07:59 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.E8.40133.ECFFCA46; Tue, 11 Jul 2023 16:07:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230711070758epcas2p4111d4413d669a8ef6dc8862a0f4835b9~wvnbs3dtX2093020930epcas2p4V;
        Tue, 11 Jul 2023 07:07:58 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230711070758epsmtrp1d0716f7e0904fd6557f422da4f8bc533~wvnbsF_xP2534725347epsmtrp1r;
        Tue, 11 Jul 2023 07:07:58 +0000 (GMT)
X-AuditID: b6c32a46-4edb870000009cc5-cc-64acffce252d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.B8.64355.ECFFCA46; Tue, 11 Jul 2023 16:07:58 +0900 (KST)
Received: from jehoon-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.133]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230711070758epsmtip120acf226bbe70c294dad113d4644fa95~wvnbfu3EV1608916089epsmtip1n;
        Tue, 11 Jul 2023 07:07:58 +0000 (GMT)
From:   Jehoon Park <jehoon.park@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>
Subject: [ndctl PATCH 0/2] add support for Set Alert Configuration mailbox
 command
Date:   Tue, 11 Jul 2023 16:10:17 +0900
Message-Id: <20230711071019.7151-1-jehoon.park@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmqe65/2tSDCat07W4+/gCm0Xz5MWM
        FtOnXmC0OHGzkc1i/9PnLBYHXjewWyw+OoPZ4ugeDovzs06xWKz88YfV4taEY0wO3B6L97xk
        8ti0qpPN48XmmYwefVtWMXp83iQXwBqVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGto
        aWGupJCXmJtqq+TiE6DrlpkDdJmSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8
        QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj0uVW9oKlwhULW2axNTB+4+ti5OSQEDCRWNO8mxHE
        FhLYwSix6EFmFyMXkP2JUeL8rndMcM6RexsZYTomLnvDApHYyShxdeZ6Vginl0lia9sMVpAq
        NgFtifvbN7CB2CICshLN6x6AjWIWaGCWeLfqKlCCg0NYIESi4X4WiMkioCqx+7YGSDmvgLVE
        N9RJEgLyEqs3HGAGaZUQOMYucfDjDGaIhIvE1LblLBC2sMSr41vYIWwpiZf9bVB2vsTPk7dY
        IewCiU9fPkDVG0u8u/mcFWQvs4CmxPpd+iCmhICyxJFbYBXMAnwSHYf/skOEeSU62oQgGlUl
        uo5/gLpMWuLwlaPMECUeEpdbjCFhGCuxaW0b0wRG2VkI4xcwMq5iFEstKM5NTy02KjCCx1By
        fu4mRnBK03LbwTjl7Qe9Q4xMHIyHGCU4mJVEeAsOrkoR4k1JrKxKLcqPLyrNSS0+xGgKDKyJ
        zFKiyfnApJpXEm9oYmlgYmZmaG5kamCuJM57r3VuipBAemJJanZqakFqEUwfEwenVAPThIrz
        tz8sC+G8+YFbQb0gweq26Mu5NnKPF767+7Q7j/PE7M6+Tq13934zXWQxNG7+bMc1+beFqco0
        FfWklR5nOHf0b2o4axeyPDdR9MW9VQ3uzd5H390KVVmiksWlVmgbpTq/a2/BaoWbzv5LPYQd
        GO54/FzWtmfx5FMXPxYuWhs9dwHfx/qDtf3ht54sX7Sx07MqzL3ZJOSKz9sF79e9FWp4cnPB
        +iJLDpe98+xWJf8rz2Vxe7AoZcFLqZXN1gpTd2TPMGJ20ljgqf+tu+/yWrtVOxpTU+u3e7CK
        aqdonj7BuMfalMFHZtrnigl10z6yvXb/w/RKxD5AvXpTs27JprXlvpGzF4dMd9l35ehsJZbi
        jERDLeai4kQAvJPHLPIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LZdlhJTvfc/zUpBhfuclncfXyBzaJ58mJG
        i+lTLzBanLjZyGax/+lzFosDrxvYLRYfncFscXQPh8X5WadYLFb++MNqcWvCMSYHbo/Fe14y
        eWxa1cnm8WLzTEaPvi2rGD0+b5ILYI3isklJzcksSy3St0vgyrh0uZW9YKlwxcKWWWwNjN/4
        uhg5OSQETCQmLnvD0sXIxSEksJ1R4uqVDjaIhLTEveYr7BC2sMT9liOsEEXdTBI/rs5nAUmw
        CWhL3N++AaxBREBWonndAyaQImaBLmaJg/t/gyWEBYIkPs9vA0pwcLAIqErsvq0BEuYVsJbo
        bt7NCLFAXmL1hgPMExh5FjAyrGIUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQIDjKtoB2My9b/
        1TvEyMTBeIhRgoNZSYS34OCqFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yjmdKUIC6Yklqdmp
        qQWpRTBZJg5OqQYmheqPl19Ozfy5PUrJLoXJI/rLu1CtLVY/j5qJM7xju+lt8/7q6rjpj1a9
        t7hb5Hl75W2zVYFN79u+TAzNrBBuv5v+l4NPMjX3WsWv94wPH+nzJG1S0l9zln2tKleieOcd
        VjXNrEOz81cx8rFISC+7xXf76VmHd0L7JJSD+qVm8Hzf8jk+8JK/SLjx2q26e9byvX145kxj
        4aOsP1n1TyO78vKt7qjJf3p2tHjetgM+ejWHjvB7y9nvjIqIkn10tyTdbtHlZUEXZO8f8+RY
        esM7xNHU6vWtGaaJ86IvB7QnLTDROWanMy/6w+ZZ/K9yFGeFpJdG9boJhr1Z2NZo1cLPeHf7
        m93X8v2lnbnrX9UqsRRnJBpqMRcVJwIADmEOcKECAAA=
X-CMS-MailID: 20230711070758epcas2p4111d4413d669a8ef6dc8862a0f4835b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230711070758epcas2p4111d4413d669a8ef6dc8862a0f4835b9
References: <CGME20230711070758epcas2p4111d4413d669a8ef6dc8862a0f4835b9@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL 3.0 Spec 8.2.9.8.3.3 defines Set Alert Configuration mailbox command.
This patchset adds support for the command to configure warning alert.

Example:
# ./cxl set-alert-config mem0 -L 30 --life-used-alert=on
{
  "memdev":"mem0",
  "ram_size":"1024.00 MiB (1073.74 MB)",
  "alert_config":{
    "life_used_prog_warn_threshold_valid":true,
    "dev_over_temperature_prog_warn_threshold_valid":false,
    "dev_under_temperature_prog_warn_threshold_valid":false,
    "corrected_volatile_mem_err_prog_warn_threshold_valid":false,
    "corrected_pmem_err_prog_warn_threshold_valid":false,
    "life_used_prog_warn_threshold_writable":true,
    "dev_over_temperature_prog_warn_threshold_writable":true,
    "dev_under_temperature_prog_warn_threshold_writable":true,
    "corrected_volatile_mem_err_prog_warn_threshold_writable":true,
    "corrected_pmem_err_prog_warn_threshold_writable":true,
    "life_used_crit_alert_threshold":75,
    "life_used_prog_warn_threshold":30,
    "dev_over_temperature_crit_alert_threshold":0,
    "dev_under_temperature_crit_alert_threshold":0,
    "dev_over_temperature_prog_warn_threshold":0,
    "dev_under_temperature_prog_warn_threshold":0,
    "corrected_volatile_mem_err_prog_warn_threshold":0,
    "corrected_pmem_err_prog_warn_threshold":0
  },
  "serial":"0",
  "host":"0000:0d:00.0"
}
cxl memdev: cmd_set_alert_config: set alert configuration 1 mem

The implementation is based on the 'ndctl-inject-smart'. Variable and function
names are aligned with the implementation of 'Get Alert Configuration'.

Jehoon Park (2):
  libcxl: add support for Set Alert Configuration mailbox command
  cxl: add 'set-alert-config' command to cxl tool

 Documentation/cxl/cxl-set-alert-config.txt |  96 +++++++++
 Documentation/cxl/lib/libcxl.txt           |   1 +
 Documentation/cxl/meson.build              |   1 +
 cxl/builtin.h                              |   1 +
 cxl/cxl.c                                  |   1 +
 cxl/lib/libcxl.c                           |  21 ++
 cxl/lib/libcxl.sym                         |  12 ++
 cxl/lib/private.h                          |  12 ++
 cxl/libcxl.h                               |  16 ++
 cxl/memdev.c                               | 219 ++++++++++++++++++++-
 10 files changed, 379 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/cxl/cxl-set-alert-config.txt


base-commit: 7f75ce36ce3a0d41ed74d4e2dfcfd41a6fd7fe40
-- 
2.17.1

