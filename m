Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5A1C04E69
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 18:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjGYSkP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjGYSkE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 14:40:04 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9E212A
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 11:39:59 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230725183957usoutp01cb0ac2b7d0945f87dcc750325c3c5dca~1MFm2x1Ci1107711077usoutp01t;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230725183957usoutp01cb0ac2b7d0945f87dcc750325c3c5dca~1MFm2x1Ci1107711077usoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690310397;
        bh=B1j67K7Wo9LB7R3854Ms8sUmfcxuACxDq7d7l8I3jpQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=WNtt5pMK94OK6Vmm6bWyFrK35uvZryYfkPY6w+NqxRPFAyw4n3Vg5zGOkC6jHJibQ
         SIv7dJkyymB5p5c/biYQWLSuQ+UQXgZlni5Lzitv6N4OSXtuZT6MHVuQ+pgljaqwpq
         7WNNX1YY5Txn/iqwR2lY6sLrleyBRCVXpQ91hPDM=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230725183956uscas1p19e375d2106e3399f7a8036e23a16153f~1MFmr36MM2195121951uscas1p1m;
        Tue, 25 Jul 2023 18:39:56 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 42.DD.51475.CF610C46; Tue,
        25 Jul 2023 14:39:56 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230725183956uscas1p154e945516c2a4091479f4906d7652648~1MFmIgDjd1452314523uscas1p1B;
        Tue, 25 Jul 2023 18:39:56 +0000 (GMT)
X-AuditID: cbfec36d-8a3ff7000001c913-3e-64c016fc5d02
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id E2.83.44215.BF610C46; Tue,
        25 Jul 2023 14:39:56 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 25 Jul 2023 11:39:55 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        25 Jul 2023 11:39:55 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: [Qemu PATCH v2 0/9] Enabling DCD emulation support in Qemu
Thread-Topic: [Qemu PATCH v2 0/9] Enabling DCD emulation support in Qemu
Thread-Index: AQHZvydn8pbwbQd4g0ikjj4shw3FGw==
Date:   Tue, 25 Jul 2023 18:39:55 +0000
Message-ID: <20230725183939.2741025-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djXc7p/xA6kGDxeoG3RfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8bl/rVsBXt5Kq696GJrYJzK1cXIySEhYCLxZnc3SxcjF4eQwEpGiQvvnjFBOK1M
        EqfP/2aEqXq5ZyI7RGIto8Tqy41QVZ8YJbrO/IXqX8Yo0dp6mhWkhU1AUWJf13Y2EFtEwFji
        2OElzCBFzAJvWSQ+rnnDApIQFnCWWNrxigWiyENi6YH9rBC2nsSyZTeZQWwWAVWJjpU7mEBs
        XgFLif2LZ4LVMAqISXw/tQYsziwgLnHryXwmiFsFJRbN3sMMYYtJ/Nv1kA3ClpeY/GMGlK0o
        cf/7S3aIXj2JG1OnsEHY2hLLFr5mhtglKHFy5hMWiHpJiYMrboB9KSHwhUPizMWjrBAJF4kt
        i1ugFktL/L27DMjmALKTJVZ9hIZwjsT8JVug5lhLLPyzHupmPom/vx4xTmBUnoXkhVlITpqF
        5KRZSE5awMiyilG8tLg4Nz212DAvtVyvODG3uDQvXS85P3cTIzDBnf53OHcH445bH/UOMTJx
        MB5ilOBgVhLhNYzZlyLEm5JYWZValB9fVJqTWnyIUZqDRUmc19D2ZLKQQHpiSWp2ampBahFM
        lomDU6qBaQLX/Po1k3cfz6/aFJKgtH3WBp1pa/ceKJ5+m020YN+W6Lv7+SYmm3zdsMhvf/Rl
        taATH1wLJaz1p0ZejNCTr/ZTt/Fr7lTl3coumK932H4ee5RzfZWK2Nvj2c9XanSGeSvouRjz
        WPz4by/14FxsSm0Zr9dlxUNKxpcezw1zPsPjx/H/uo2nn6XdaxU31SzzHdySn668yxKP5uJ/
        Kv7F12z6pnU32qa7l5y9pWW7y3j6nnvn+5InWH5zOBApqxq99m6k6ITepLkq004WivOsyF9Q
        PCPPw+6fmk+o7ESjTWzv3n3Z/NL4RciDZ8IK+3tFZvlfX7awYmeLXSRXp/KmD4ffqVR+u6Br
        v5/Z5O5MJZbijERDLeai4kQA+lsPat8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWS2cA0UfeP2IEUg4/rOC26z29gtJg+9QKj
        xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
        rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
        Sy3St0vgyrjcv5atYC9PxbUXXWwNjFO5uhg5OSQETCRe7pnI3sXIxSEksJpR4sTeZhYI5xOj
        xPXzP5ghnGWMEosPL2AHaWETUJTY17WdDcQWETCWOHZ4CTOIzSzwmkXi20VuEFtYwFliaccr
        FogaD4mlB/azQth6EsuW3QSrZxFQlehYuYMJxOYVsJTYv3gmWA2jgJjE91NrmCBmikvcejKf
        CeJUAYkle84zQ9iiEi8f/2OFsOUlJv+YwQZhK0rc//6SHaJXT+LG1ClsELa2xLKFr5khdglK
        nJz5hAWiXlLi4IobLBMYxWYhWTcLSfssJO2zkLQvYGRZxSheWlycm15RbJSXWq5XnJhbXJqX
        rpecn7uJERjrp/8djt7BePvWR71DjEwcjIcYJTiYlUR4DWP2pQjxpiRWVqUW5ccXleakFh9i
        lOZgURLnfRk1MV5IID2xJDU7NbUgtQgmy8TBKdXAFO6XmZf79vZCU5POyxVXN5w8oL5Lynzy
        konPqt+ftlgjz229MeBTx4Le2ET1wOneMczmYqu4pA7ELmr++Heq+FyWKstqA5MZGaV7NBuV
        7wbxSi0780fZa2Z+AsfDrUV//s/VCQ5eInDx+F6Re4v9XjwP5gvU9Ph5x32BDvOeu2V+6fVb
        9paIub+y35yxxiHro99kVcVi3+lxdmkctkcKd3JPfsRlqiscsqw0YUHcgppljutVzVz5xGW/
        Bh/4Y1ReyTRpmfvWae9yXLO7v8XPm2auVbngUZ1tiH1pMuvujLf/HNLt2/c1PbztkrShJlFQ
        +UThSbM8HQepjNx65Z3dst5yvyTXl/VmsZtOFVNiKc5INNRiLipOBADZ1pLiZAMAAA==
X-CMS-MailID: 20230725183956uscas1p154e945516c2a4091479f4906d7652648
CMS-TYPE: 301P
X-CMS-RootMailID: 20230725183956uscas1p154e945516c2a4091479f4906d7652648
References: <CGME20230725183956uscas1p154e945516c2a4091479f4906d7652648@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v1[1]->v2:

1. fix a regression issue reported by Ira[2]:
2. fix a compile warning due to uninitialized 'rip' in qmp processing funct=
ion.


[1] https://lore.kernel.org/linux-cxl/20230724162313.34196-1-fan.ni@samsung=
.com/T/#t
[2] https://lore.kernel.org/linux-cxl/64bfe7b090843_12757b2945b@iweiny-mobl=
.notmuch/T/#m09983a3dbaa9135a850e345d86714bf2ab957ef6

Fan Ni (9):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
    type3 memory devices
  hw/mem/cxl_type3: Add support to create DC regions to type3 memory
    devices
  hw/mem/cxl_type3: Add host backend and address space handling for DC
    regions
  hw/mem/cxl_type3: Add DC extent list representative and get DC extent
    list mailbox support
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
    extents
  hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions

 hw/cxl/cxl-mailbox-utils.c  | 424 +++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 545 +++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |   6 +
 include/hw/cxl/cxl_device.h |  50 +++-
 include/hw/cxl/cxl_events.h |  16 ++
 qapi/cxl.json               |  49 ++++
 6 files changed, 1044 insertions(+), 46 deletions(-)

--=20
2.25.1
