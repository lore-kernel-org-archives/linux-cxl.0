Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C550DE6FE22
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Sep 2023 13:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjIVNDJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Sep 2023 09:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjIVNDH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Sep 2023 09:03:07 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B7DC6
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 06:03:00 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230922130255epoutp038fb6d11903ce8d4927011562caecd027~HOjMelCfO0917909179epoutp03d
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 13:02:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230922130255epoutp038fb6d11903ce8d4927011562caecd027~HOjMelCfO0917909179epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695387776;
        bh=Q5f3pAad1Kya9AnCJ/9CyhFys/w2HDU4OGdPbBTuf9A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oUhjaFa0HFBkpnpMFDSKK6IX9qMYyKnTujAlx5VNWfuy+spxPkPXY1g4Yw+L5D49r
         DWIUC5GlYeR6IW4a1Xu2FaQs/KQu7AZeY2OO5h65tzK+BcBjmWgqMbCsmmh0fblA4S
         HuYPSh6y2n8Tpk279aFSapw9QEkFkIngll3jKp/I=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230922130255epcas2p3df084f28eb22203f1317768b4110aeb1~HOjL886LK0534605346epcas2p3F;
        Fri, 22 Sep 2023 13:02:55 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RsXW261vfz4x9Pv; Fri, 22 Sep
        2023 13:02:54 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.0E.19471.E709D056; Fri, 22 Sep 2023 22:02:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230922130253epcas2p3112ca71e8a1dcf42967543063322df1e~HOjKpTQZh0301703017epcas2p3X;
        Fri, 22 Sep 2023 13:02:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230922130253epsmtrp12c4bd35eceaee52b78e51709b2cdfe12~HOjKoYHDd3196931969epsmtrp1q;
        Fri, 22 Sep 2023 13:02:53 +0000 (GMT)
X-AuditID: b6c32a4d-b07ff70000004c0f-de-650d907ecf10
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.69.08788.D709D056; Fri, 22 Sep 2023 22:02:53 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230922130253epsmtip28ee289bf68daf105720eebf1396ba058~HOjKXYBeu0296802968epsmtip2f;
        Fri, 22 Sep 2023 13:02:53 +0000 (GMT)
From:   Jeongtae Park <jtp.park@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>,
        Jeongtae Park <jtp.park@samsung.com>
Subject: [RFC PATCH 0/3] cxl: Fix background operation handling
Date:   Fri, 22 Sep 2023 22:05:28 +0900
Message-Id: <20230922130528.3475445-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmqW7dBN5Ug8tztCzuPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFh/e/GOxOPC6gd3izNmXrBarFl5jsziy9iqTxeKjM5gt
        ju7hsDg/6xSLxa0Jx5gsNt5/x+Yg4LFz1l12j5Yjb1k9Fu95yeSxaVUnm0ffllWMHlNn13t8
        3iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD
        dLuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDI
        FKgwITvjc89x9oIZ3BU9uy+wNTDe4Ohi5OSQEDCRWPP4M2MXIxeHkMAeRokNbyawQzifGCUa
        Vl1mAqkSEvjGKHF6UTRMx6eHM5khivYySvxdfZMFwvnDKLFu3T+wDjYBLYnpMxtYQWwRAVmJ
        5nUPmECKmAWuskhMOnURrEhYwF5i4dVdjCA2i4CqROPLTWBxXgFriaXTOpgh1slL7D94lhki
        LihxcuYTFhCbGSjevHU22BkSAnM5JC5OWcoI0eAi8WxPP1SzsMSr41vYIWwpiZf9bewQDc2M
        Eq+fX2GBcFqA7r69A6rKWOLdzedAd3MArdCUWL9LH8SUEFCWOHILajGfRMfhv+wQYV6JjjYh
        iEYliXlL50GtlZC4NHcLlO0hcX7dX3ZIMMZKLDnQyzKBUX4WkndmIXlnFsLeBYzMqxilUguK
        c9NTk40KDHXzUsvhUZucn7uJEZyItXx3ML5e/1fvECMTB+MhRgkOZiUR3uRPXKlCvCmJlVWp
        RfnxRaU5qcWHGE2BgTyRWUo0OR+YC/JK4g1NLA1MzMwMzY1MDcyVxHnvtc5NERJITyxJzU5N
        LUgtgulj4uCUamBKYMwzyfimpZjh8UdFZqGBzPuqTNvfO7veiLnZ6mfMWrnpdv3KJp7Df6wP
        TSqu3c2SPfthXk6TycpNs6w75my91+P92tliVnC2gqh2E5cyY4yy1ovg1jdNU9aXJ+/66fMs
        lDX6zqKzz2+/1H/AkWYxy/F0tKLXhDe/WvavvLfM8wT7PuVyzm37jvp76N7UMvx37IH9jhue
        q85NDnjxVPCx8CTu1+Jx0+5kdi1UvWe1rWVSuI0oQ/RUAc5tn1pnnWloyCs4W7/2wSb3nUe2
        h5/ZHnPi0tqFM+tVzB8VM7LsfPVmWvddbRO+LXufP9x+9eH9qARF3sOi06sm+tyP+F4VaFb6
        v1LqqkZyqLfMeTNlJZbijERDLeai4kQAzzwiXk0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvG7tBN5UgycrjCzuPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFh/e/GOxOPC6gd3izNmXrBarFl5jsziy9iqTxeKjM5gt
        ju7hsDg/6xSLxa0Jx5gsNt5/x+Yg4LFz1l12j5Yjb1k9Fu95yeSxaVUnm0ffllWMHlNn13t8
        3iQXwB7FZZOSmpNZllqkb5fAlfG55zh7wQzuip7dF9gaGG9wdDFyckgImEh8ejiTuYuRi0NI
        YDejxOHHE9ggEhISyze8YIKwhSXutxxhhSj6xSgx9+4JFpAEm4CWxPSZDawgtoiArETzugdM
        IEXMAg9ZJLbd/sAIkhAWsJdYeHUXmM0ioCrR+HIT2FReAWuJpdM6mCE2yEvsP3iWGSIuKHFy
        5hOwBcxA8eats5knMPLNQpKahSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZG
        cExoae1g3LPqg94hRiYOxkOMEhzMSiK8yZ+4UoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvd
        myIkkJ5YkpqdmlqQWgSTZeLglGpgmujCFrtv66VVD9ddjWNfc3Z/V3fe6kzuFbsmicnsVJsf
        ndJ2WMLpVpKNcJhjhuuxrOcu37mM3mqZRM+NFjpiULxDSmkj86fJkUnMH+Y+emV9YHtN743G
        8Lc5Givke9Xf7RF6whF59NSbZ6VnfndpVSv4JLieF5Pv9F95Kbs0zdDgCIP0hERbvx7heleX
        M/WtR7pzDhmpCDBe5s2ViIzkurn1+oaZfy8b/VUIunWQ73vEOfVHlxSmNhrzPFgX/ya1e8Z+
        qQ0dz+0n67xcPe1XsWDv4UZnLzNzP6tZ67Oyk1h3enMkrN16ovmNwAL/g/ddpdJFjx3+JX+7
        MvyNpEzjHNeyq3tUb87UXKHo3rVWiaU4I9FQi7moOBEAaT+Iy/gCAAA=
X-CMS-MailID: 20230922130253epcas2p3112ca71e8a1dcf42967543063322df1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922130253epcas2p3112ca71e8a1dcf42967543063322df1e
References: <CGME20230922130253epcas2p3112ca71e8a1dcf42967543063322df1e@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

We are currently trying to add background commands like
fw-related and sanitize operation. However, as we modified 
the code, we found that there was a lot of duplication of
code, so we would like to modify the existing background 
command handling a little bit. We want to make the most of
the existing background command handling so that we can
easily add other background commands in the future.

The first patch modifies the existing sanitize operation
handling to allow other background commands to be used 
with it, and the second patch modifies sanitize to work
with the modified code. Finally, the third patch adds a
sysfs file related to the background operation. 
This sysfs entry is select/poll capable from userspace 
to notify upon completion of a background operation.

Thanks,
/jtpark

Jeongtae Park (3):
  cxl: Modify background cmd handling for the others
  cxl/mbox: Update sanitize opcode support
  cxl/memdev: Add background command sysfs file

 Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++
 drivers/cxl/core/mbox.c                 |  5 +-
 drivers/cxl/core/memdev.c               | 71 +++++++++++++++++++++++--
 drivers/cxl/cxlmem.h                    | 33 ++++++++++--
 drivers/cxl/pci.c                       | 65 +++++++++++-----------
 5 files changed, 141 insertions(+), 43 deletions(-)


base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
-- 
2.34.1

