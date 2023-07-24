Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF1C001B0
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGXQXc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjGXQXa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 12:23:30 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A36E47
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 09:23:25 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230724162323usoutp023cc8b5fcd22eb61941b11b9dce9281de~02lF9Q7k91330013300usoutp020;
        Mon, 24 Jul 2023 16:23:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230724162323usoutp023cc8b5fcd22eb61941b11b9dce9281de~02lF9Q7k91330013300usoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690215803;
        bh=k4rnuurUQ9HzwUHiba00ZsEth7as+qyqvBcGdVELUUc=;
        h=From:To:CC:Subject:Date:References:From;
        b=N5T8wdEJ+vmQoA+8aetwFvn1VrJqFUeaB89C8z00y//Z5LfVpbxKCUp0Q1yx8rp0d
         MUitnDBm+RSK33V4YBQDgakkzSnY9JaGLuqiJGOb+dKmJ5fD5Ia5kU3Pm8DjTVXD0Y
         Y22HgGcXgtRBnyU8oltCrzQHZ/ZCdXqdzoakCaX4=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162323uscas1p2b48189df093ee8537104e508b88373c9~02lFyBELN0636506365uscas1p2B;
        Mon, 24 Jul 2023 16:23:23 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 3E.05.51475.B75AEB46; Mon,
        24 Jul 2023 12:23:23 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162322uscas1p2578574c26c5d5b92c695bc36404242c2~02lFO7WZ60402004020uscas1p2j;
        Mon, 24 Jul 2023 16:23:22 +0000 (GMT)
X-AuditID: cbfec36d-8a3ff7000001c913-93-64bea57b0efd
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 34.9A.44215.A75AEB46; Mon,
        24 Jul 2023 12:23:22 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 24 Jul 2023 09:23:22 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        24 Jul 2023 09:23:22 -0700
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
Subject: [Qemu PATCH RESEND 0/9] Enabling DCD emulation support in Qemu
Thread-Topic: [Qemu PATCH RESEND 0/9] Enabling DCD emulation support in Qemu
Thread-Index: AQHZvksp2bw7Dgb440GNbJM6Ngh03A==
Date:   Mon, 24 Jul 2023 16:23:22 +0000
Message-ID: <20230724162313.34196-1-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7djX87rVS/elGHxdIm7RfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8bUyxeYCw5JVPzc+Jy9gbFLpIuRk0NCwETi0a6trF2MXBxCAisZJa49e8YC4bQy
        STRP/cQIU/Vy0WVmiMRaRomWtdMZIZxPjBLLzzRDtSxjlLi+oIcdpIVNQFFiX9d2NhBbRMBY
        4tjhJWDtzAJvWSQ+rnkD1MHBISzgLtE9LRqixkdi8eZ17CBhEQE9iT8nYkHCLAKqEod29ION
        5BUwlziy/QXYRYwCYhLfT61hArGZBcQlbj2ZzwRxqaDEotl7mCFsMYl/ux6yQdjyEpN/zICy
        FSXuf3/JDtGrJ3Fj6hQ2CFtbYtnC18wQuwQlTs58wgJRLylxcMUNsB8lBH5wSNy88wNqkIvE
        1007oEEkLfH37jImkPslBJIlVn3kggjnSMxfsgVqjrXEwj/roW7mk/j76xHjBEblWUhemIXk
        pFlITpqF5KQFjCyrGMVLi4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxApPb6X+Hc3cw7rj1Ue8Q
        IxMH4yFGCQ5mJRFew5h9KUK8KYmVValF+fFFpTmpxYcYpTlYlMR5DW1PJgsJpCeWpGanphak
        FsFkmTg4pRqYgl4bMXRPnDXhSJgZ5yLOjksXufmbewTqWV7p9vKbrnt5Ypvnwp/uJj1u041u
        eq1+xjzza9TGzvsv+lxZE38ddl7uV3gq/nrshf07zGJORew68VZ1Q8bUoMkWjnfPPP2iu0jb
        lJFBps3dbYnl10zmI21le1Z6iH1knOzhoDT5yHqDN3XPdm//JsDNw+nNFSbtcWLaQcX7h5If
        CSv07bJVSzPP/trN4f257dNks7KZpX2RawsbPdt8VObPaN50c6PWvc/JRVwL1ld77na5ziy1
        ubphV3K3rKSGy8tFz/J+cSyK67n/71z9ir51z+9VTgly8PUXUOHuu3V8ss2bPQY7tqvsnf5U
        cZ/XzL/dUyuNlViKMxINtZiLihMBphrBzN0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWS2cA0Sbdq6b4Ug71HDSy6z29gtJg+9QKj
        xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
        rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
        Sy3St0vgyph6+QJzwSGJip8bn7M3MHaJdDFyckgImEi8XHSZuYuRi0NIYDWjxLd9fxkhnE+M
        Eof23WGHcJYxSrTPmMwG0sImoCixr2s7mC0iYCxx7PASZhCbWeA1i8S3i9xdjBwcwgLuEt3T
        oiFKfCQWb17HDhIWEdCT+HMiFiTMIqAqcWhHPzuIzStgLnFk+wtGEJtRQEzi+6k1TBATxSVu
        PZnPBHGogMSSPeeZIWxRiZeP/7FC2PISk3/MYIOwFSXuf3/JDtGrJ3Fj6hQ2CFtbYtnC18wQ
        uwQlTs58wgJRLylxcMUNlgmMYrOQrJuFpH0WkvZZSNoXMLKsYhQvLS7OTa8oNspLLdcrTswt
        Ls1L10vOz93ECIzz0/8OR+9gvH3ro94hRiYOxkOMEhzMSiK8hjH7UoR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzvoyaGC8kkJ5YkpqdmlqQWgSTZeLglGpgMn491evguhJRzqf9C0IbDorGza9N
        4a1k4/ffzXmeuVFG2zlz894kq8LvBhdmHSjh6bqpp7d95eQnmu5Pl77mSt809XDMPLcTb86w
        dTXUvnoeNefWZ1kTf54ZZ/dIREtJL4iWccnbfUDxUtekYHW5xXXT3os83SJq0hrj8mI5885H
        cyawm1VPFFYs0Fiv81Zhg8yj/q818VsaMnLUJEsF2HTj75Q8fff+6ppN4et+BM/Zbb68OefF
        M5e3W9UTXG7ddLQ+c6lQ/k9oXwZX19mZAktVLnF99pT0btjKuHCTkIsEb535cfFtu701BR6s
        32Of/7hmO89qU/tqjdPhNof3PFuZ1ON93uiEsIj97dqPSizFGYmGWsxFxYkA+ipbG2IDAAA=
X-CMS-MailID: 20230724162322uscas1p2578574c26c5d5b92c695bc36404242c2
CMS-TYPE: 301P
X-CMS-RootMailID: 20230724162322uscas1p2578574c26c5d5b92c695bc36404242c2
References: <CGME20230724162322uscas1p2578574c26c5d5b92c695bc36404242c2@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The patch series provides dynamic capacity device (DCD) emulation in Qemu.
More specifically, it provides the following functionalities:
1. Extended type3 memory device to support DC regions and extents.
2. Implemented DCD related mailbox command support in CXL r3.0: 8.2.9.8.9.
3. ADD QMP interfaces for adding and releasing DC extents to simulate FM
functions for DCD described in cxl r3.0: 7.6.7.6.5 and 7.6.7.6.6.
4. Add new ct3d properties for DCD devices (host backend, number of dc
regions, etc.)
5. Add read/write support from/to DC regions of the device.
6. Add mechanism to validate accessed to DC region address space.

A more detailed description can be found from the previously posted RFC[1].

Compared to the previously posted RFC[1], following changes have been made:
1. Rebased the code on top of Jonathan's branch
https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25.
2. Extracted the rename of mem_size to a separated patch.(Jonathan)
3. Reordered the patch series to improve its readability.(Jonathan)
4. Split the validation of accesses to DC region address space as a separat=
e
patch.
5. Redesigned the QMP interfaces for adding and releasing DC extents to mak=
e
them easier to understand and act like existing QMP interfaces (like the
interface for cxl-inject-uncorrectable-errors). (Jonathan)
6. Updated dvsec range register setting to support DCD devices without stat=
ic
capacity.
7. Fixed issues mentioned in the comments (Jonathan&Nathan Fontenot).
8. Fixed the format issue and checked with checkpatch.pl under qemu code di=
r.


The code is tested with the DCD patch series at the kernel side[2]. The tes=
t
is similar to those mentioned in the cover letter of [1].


[1]: https://lore.kernel.org/all/20230511175609.2091136-1-fan.ni@samsung.co=
m/
[2]: https://lore.kernel.org/linux-cxl/649da378c28a3_968bb29420@iweiny-mobl=
.notmuch/T/#t

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

 hw/cxl/cxl-mailbox-utils.c  | 421 +++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 539 +++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |   6 +
 include/hw/cxl/cxl_device.h |  49 +++-
 include/hw/cxl/cxl_events.h |  16 ++
 qapi/cxl.json               |  49 ++++
 6 files changed, 1034 insertions(+), 46 deletions(-)

--=20
2.25.1
