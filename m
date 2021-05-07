Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_05,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCC5C433B4
	for <linux-cxl@archiver.kernel.org>; Fri,  7 May 2021 01:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C1A6105A
	for <linux-cxl@archiver.kernel.org>; Fri,  7 May 2021 01:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhEGBsd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 May 2021 21:48:33 -0400
Received: from usmail.montage-tech.com ([12.176.92.53]:59569 "EHLO
        usmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbhEGBsd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 6 May 2021 21:48:33 -0400
X-MDAV-Result: clean
X-MDAV-Processed: usmail.montage-tech.com, Thu, 06 May 2021 18:47:33 -0700
Received: from shmail.montage-tech.com by usmail.montage-tech.com with ESMTP id md5001005625861.msg; 
        Thu, 06 May 2021 18:47:33 -0700
X-MDArrival-Date: Thu, 06 May 2021 18:47:33 -0700
X-Return-Path: prvs=17616916e5=david.dai@montage-tech.com
X-Envelope-From: david.dai@montage-tech.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1620352046; x=1620956846;
        i=david.dai@montage-tech.com; q=dns/txt; h=From:To:Cc:Subject:
        Date:Message-ID:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Thread-Index:Content-Language; bh=L3Un
        rB+anJNjNP/B1rxssibRE0awsbP+NwB9L6IFo2k=; b=gbvXeSxwzs54aZW3uBQ/
        JNOb1fDWUk6O5mSQpneTaPvtJL4JUXT2vZ8wWjbh4JHruIrbkDfJI0OBRlQKvsL7
        3Oov8AKnKm5H8iC7fK26zhCAfdM6N/ty8AXuYsDpSDSPeh+HvO5GFsie0qyupm6+
        0nwFEiw+i9cQuQx0bbBZ97g=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Fri, 07 May 2021 09:47:26 +0800
Received: from cn021pc868 by shmail.montage-tech.com with ESMTPSA id pp5001016722846.msg; 
        Fri, 07 May 2021 09:47:25 +0800
From:   "Dai WeiBin \(David Dai\)" <david.dai@montage-tech.com>
To:     "'Ben Widawsky'" <ben.widawsky@intel.com>
Cc:     <linux-cxl@vger.kernel.org>,
        "'Linux ACPI'" <linux-acpi@vger.kernel.org>,
        "'Dan Williams'" <dan.j.williams@intel.com>
Subject: CXL HDM alignment
Date:   Fri, 7 May 2021 09:43:47 +0800
Message-ID: <003501d742e2$6c331c50$449954f0$@montage-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AddC3+pLppO5NLuURmKWLV+pdj+tUw==
Content-Language: zh-cn
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Ben,

I am sorry to disturb you for consulting you a question, my question is =
how I can make CXL HDM 1G-size alignment, CXL specification defines HDM =
is 256M alignment.
From my understanding, BIOS will allocate HPA and build ACPI SRAT for =
CXL HDM, do we have any method to tell OS or BIOS to align HDM with 1G =
size?

I don't sure whether we can configure BIOS address allocation, but hope =
any your suggestion and help!

Thanks,
David



