Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B5BC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Nov 2022 16:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiKVQxj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Nov 2022 11:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiKVQxi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Nov 2022 11:53:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94A813F9C
        for <linux-cxl@vger.kernel.org>; Tue, 22 Nov 2022 08:53:36 -0800 (PST)
Received: from frapeml100005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NGqyY1Nk6z6883d;
        Wed, 23 Nov 2022 00:51:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 17:53:34 +0100
Received: from localhost (10.45.149.88) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 16:53:34 +0000
Date:   Tue, 22 Nov 2022 16:53:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Julien BERAUD <jberaud@sasfermat.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: Prototyping on CXL hardware
Message-ID: <20221122165331.00006923@Huawei.com>
In-Reply-To: <40fbb3ef-ccf5-bfbb-675c-861948beba56@sasfermat.com>
References: <40fbb3ef-ccf5-bfbb-675c-861948beba56@sasfermat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.149.88]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 22 Nov 2022 10:54:52 +0100
Julien BERAUD <jberaud@sasfermat.com> wrote:

> Hello Everyone,
> 

Hi Julien, Nice to 'meet' you.

> I'm currently trying to prototype with a simple use-case on a CXL type 3 device
> directly connected to a CXL 2.0 capable server.
> 
> Since I have seen many patches being integrated in the mainline kernel, I am 
> running a 6.0.1 release.
> 
> The init phase of the drivers fails with the following trace:
> 
> cxl_mem mem0: at mem0 no parent for dport: pci0000:16
> 
> It occurs at the first iteration of the loop in devm_cxl_enumerate_ports 
> 
> The previous steps have been succeding as far as I know.
> 
> ---------------------------------------------------------------------------------
> So I have a few questions that I hope someone can answer here, I am sorry if they
> sound naive :
> 
> - What is supposed to fill the device's ancestry, and what does it means if there
> is none ?
> 
> - More generally, is a CXL type 3 device directly connected to a CXL capable
> server supposed to initialize correctly on a 6.0.1 kernel or should I use a more
> advanced branch ?

To take a lazy punt in the dark as it end of day here.

Do you have an ACPI CEDT table and required ACPI stuff such as ACPI0017 in DSDT?
Otherwise the root of the created CXL topology will be missing - I haven't checked
the code paths, but that might well give the above result.

There are a few fixes you will want on top of 6.0.1 - but those are all around
region creation I think, so you aren't getting that far.
I've not been tracking progress of those. Dan, what's the current status?

For reference you could take a look at the upstream QEMU (very recent needed as we
had a fix going through on x86).  That should work and gives you something to compare
with when bringing up real hardware.

Jonathan

> 
> 
> Thanks in advance for your answers,
> Julien

