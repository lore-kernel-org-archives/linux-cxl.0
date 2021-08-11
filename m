Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_INVALID,DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67C8C4338F
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Aug 2021 12:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB00A60EFF
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Aug 2021 12:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbhHJMcC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 10 Aug 2021 08:32:02 -0400
Received: from usmail.montage-tech.com ([12.176.92.53]:53552 "EHLO
        usmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbhHJMcB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 10 Aug 2021 08:32:01 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2021 08:32:01 EDT
X-MDAV-Result: clean
X-MDAV-Processed: usmail.montage-tech.com, Tue, 10 Aug 2021 05:24:24 -0700
Received: from shmail.montage-tech.com by usmail.montage-tech.com with ESMTP id md5001005751581.msg; 
        Tue, 10 Aug 2021 05:24:24 -0700
X-MDArrival-Date: Tue, 10 Aug 2021 05:24:24 -0700
X-Return-Path: prvs=1856e8a9f0=johnny.li@montage-tech.com
X-Envelope-From: johnny.li@montage-tech.com
X-MDaemon-Deliver-To: linux-cxl@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1628598256; x=1629203056;
        i=johnny.li@montage-tech.com; q=dns/txt; h=Date:From:To:Cc:
        Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
        User-Agent; bh=GXinh2pZA6S2gztz9OyNBnD24vlvIgphikQ/F6UKEbA=; b=L
        zPj6wDtg9Je7hzXPeZWjpxirxa+77wJAJC/u63bpQ9uDr6hIzYav2+2slPKiHp0n
        rmJDVpboKyeOTs8WXDwbUBfeZ5TIXJkDAJCSDdkecGBLSZEpVFLtqsEiz1Q3qNfk
        L0drHKcKoZez1efzikf6uZ7NsuXj0G5ea83nKnMuyg=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Tue, 10 Aug 2021 20:24:16 +0800
Received: from montage-desktop by shmail.montage-tech.com with ESMTPA id pp5001017232500.msg; 
        Tue, 10 Aug 2021 20:24:15 +0800
Date:   Tue, 10 Aug 2021 20:18:50 -0400
From:   johnny <johnny.li@montage-tech.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan.Cameron@huawei.com, ben.widawsky@intel.com
Subject: CXL 1.1 Support Plan
Message-ID: <20210811001850.GA39621@montage-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

Current CXL patches [1] focus on CXL 2.0 support. While in the real world,
CXL 1.1 capable host and EP are the first CXL components end user can use. May I
ask community plan on CXL 1.1 support
  - CXL 1.1 host + CXL 1.1 EP
  - CXL 1.1 host + CXL 2.0 EP

[1] https://lwn.net/Articles/846061/


Thanks
Johnny


