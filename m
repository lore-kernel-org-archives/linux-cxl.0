Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_40,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C18C433C1
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 06:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BC1619E5
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 06:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhCXGwT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Mar 2021 02:52:19 -0400
Received: from shmail.montage-tech.com ([180.167.85.125]:62532 "EHLO
        shmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhCXGwD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Mar 2021 02:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1616568721; x=1617173521;
        i=david.dai@montage-tech.com; q=dns/txt; h=From:To:Subject:Date:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Thread-Index:Content-Language; bh=r4BegxRWaLuAlC0jMEwWpKzmBc9Kgn
        oQzEhK2w/C3kw=; b=ErKdSKfHrd66pbrLGLtuNO1Awrf2h3t1wAktPWaP3GqMnT
        7jyr1lgnFNp1K/7QURGSzaqNR9nNZZraWdOsne//mtS873yqqTteRfUW470syk8w
        SNBw5CNxaM45WvViiWXYSTooSVtIfnVw2g/EH+yRVYA+2+51raY3zrit5C+K8=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Wed, 24 Mar 2021 14:52:01 +0800
Received: from cn021pc868 by shmail.montage-tech.com with ESMTPSA id pp5001016533749.msg; 
        Wed, 24 Mar 2021 14:51:59 +0800
X-MDArrival-Date: Wed, 24 Mar 2021 14:51:59 +0800
X-Authenticated-Sender: david.dai@montage-tech.com
X-Return-Path: prvs=1717d22d3a=david.dai@montage-tech.com
X-Envelope-From: david.dai@montage-tech.com
X-MDaemon-Deliver-To: linux-cxl@vger.kernel.org
From:   "Dai WeiBin \(David Dai\)" <david.dai@montage-tech.com>
To:     <linux-cxl@vger.kernel.org>
Subject: CXL CDAT
Date:   Wed, 24 Mar 2021 14:49:11 +0800
Message-ID: <00b901d72079$cbe9fc80$63bdf580$@montage-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Adcgeb6lkeju7R0ASF6cPip7P/UYVw==
Content-Language: zh-cn
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,
Could anybody help to explain when cxl-2.0 CDAT must be ready? For =
example, a type3 device has a big memory which might spend hundreds of =
seconds for booting up, that means:
1. when this device has completed boot and can provide exact CDAT, but =
host BIOS might have miss the CDAT.
2. If shutdown PCIE/CXL link until device ready, host BIOS will be =
unable to find this device.

If this is true, is there any good way to solve it?


Thanks,
David



