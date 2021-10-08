Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352ADC433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Oct 2021 18:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06157611EE
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Oct 2021 18:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhJHSMx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:12:53 -0400
Received: from a11-127.smtp-out.amazonses.com ([54.240.11.127]:48013 "EHLO
        a11-127.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240082AbhJHSMK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Oct 2021 14:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=lg67htegwjqeypdgehj5bz2vdyv4b22f; d=jagalactic.com; t=1633716613;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
        bh=ohh2OowjbOE5xhIb6BZ5Rig59BY6oEkrrUVMZiJJEiU=;
        b=OsWFcg9J+M+FLoYEo188Cq+lc4KFrUWeGyneZAwrIpoOMl15ufwUhEEzFQbbpVVU
        /a+IGebt/kawcYMYuXeHLjB2UMvNidLSvyFSow0UzH3RNSXSjjl3WqebZCdSfZtiTzv
        Yfhga2OZi35vXLB6ldlGdzG54Jj0bQ1GkCU1Pzpc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1633716613;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
        bh=ohh2OowjbOE5xhIb6BZ5Rig59BY6oEkrrUVMZiJJEiU=;
        b=iP7vQuLTXI7MvpP85gQCzVo1BFEceObSsFe+w0Nv+EM1E2+KpSUERX4tbfpDNC9v
        mNsAOdkC3jDDyBqbw/8KHKgUL5nlquRS08mk2egrXLkYbBMNSIdl66IKWMWSorXcKZl
        ZSIQqoDn8xcjEbT+6VmTonxRhaPoW9gP6nw2DR14=
Subject: Re: CXL 1.1 Support Plan
From:   =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To:     =?UTF-8?Q?Verma=2C_Vishal_L?= <vishal.l.verma@intel.com>,
        =?UTF-8?Q?Williams=2C_Dan_J?= <dan.j.williams@intel.com>
Cc:     =?UTF-8?Q?johnny=2Eli=40montage-tech=2Ecom?= 
        <johnny.li@montage-tech.com>,
        =?UTF-8?Q?Widawsky=2C_Ben?= <ben.widawsky@intel.com>,
        =?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= 
        <linux-cxl@vger.kernel.org>,
        =?UTF-8?Q?Jonathan=2ECameron=40huawei=2Ecom?= 
        <Jonathan.Cameron@huawei.com>,
        =?UTF-8?Q?jgroves=40micron=2Ecom?= <jgroves@micron.com>
Date:   Fri, 8 Oct 2021 18:10:13 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: <0100017c611571b1-9210602d-93bf-49e9-b1a1-14192037961e-000000@email.amazonses.com>
References: <YT9kSHU+P5wrnm2S@BigDog.local> 
 <CAPcyv4gY7UvT7fkCcvxGwe7-s6r40rFExwLN2oc7xBtMGdRyAw@mail.gmail.com> 
 <0100017bdf9fcce1-400920ad-2274-4d39-b45e-45410426db50-000000@email.amazonses.com> 
 <dd56f465-560e-9408-d7e6-9f8de59bc792@jagalactic.com> 
 <CAPcyv4hjD=1EEAkjx+r3DRxASCGpF45kOyOZVULsMDekyG6TYQ@mail.gmail.com> 
 <0100017be5e140c0-cedfdc46-26b6-4009-899f-8dfb2268af2e-000000@email.amazonses.com> 
 <CAPcyv4g-t_kY84TSq6WbWP96hjOupXx1KYtB9XznQ4y2NooXWw@mail.gmail.com> 
 <2093cae0-ff0b-1d6d-2ff2-ba1bb41510af@jagalactic.com> 
 <0100017c38c8cbb1-c0632347-44dd-44a4-b6c2-4e33c2ba85e8-000000@email.amazonses.com> 
 <8a9b94becf407e218a544d3d0d9286ec4c698099.camel@intel.com> 
 <c55b69bd-45e3-4dec-91af-02ca4eeb054a@jagalactic.com> 
 <0100017c611571b1-9210602d-93bf-49e9-b1a1-14192037961e-000000@email.amazonses.com> 
 <dec7b376-71dd-1499-c46c-3fbc37fc2057@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: =?us-ascii?Q?AQHXjeOyDbo/H0Y69E21FQB9XsVm96ts2ugAgDVln4CAAEk?=
 =?us-ascii?Q?WAIABn6OAgAAG9ICAGUX1gIAK8xOAC6Ld+t0LowKKNg=3D=3D?=
Thread-Topic: CXL 1.1 Support Plan
X-Wm-Sent-Timestamp: 1633716612
Message-ID: <0100017c611931f4-1a73279c-194f-429d-8691-9cc5704c6472-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2021.10.08-54.240.11.127
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 10/8/21 1:06 PM, John Groves wrote:

[snip mangled message]

Will try to un-mangle and re-send that last message.

John

