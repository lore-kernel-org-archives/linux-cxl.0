Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16235C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 19 Oct 2021 06:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C6C60F25
	for <linux-cxl@archiver.kernel.org>; Tue, 19 Oct 2021 06:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhJSGIa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 19 Oct 2021 02:08:30 -0400
Received: from usmail.montage-tech.com ([12.176.92.53]:50839 "EHLO
        usmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJSGI3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 19 Oct 2021 02:08:29 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2021 02:08:29 EDT
X-MDAV-Result: clean
X-MDAV-Processed: usmail.montage-tech.com, Mon, 18 Oct 2021 22:59:47 -0700
Received: from shmail.montage-tech.com by usmail.montage-tech.com with ESMTP id md5001005844910.msg; 
        Mon, 18 Oct 2021 22:59:47 -0700
X-MDArrival-Date: Mon, 18 Oct 2021 22:59:47 -0700
X-Return-Path: prvs=1926c3430e=johnny.li@montage-tech.com
X-Envelope-From: johnny.li@montage-tech.com
X-MDaemon-Deliver-To: linux-cxl@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1634623176; x=1635227976;
        i=johnny.li@montage-tech.com; q=dns/txt; h=Date:From:To:Cc:
        Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
        User-Agent; bh=M/QuCl6WZdO0B/paCrxMr6uASsEqFdAnmlfzM40rt9E=; b=Q
        5L9rwkscQYJ12KLe3NVMbxqbac71pfhRgpx73HcVOw6xk0KYsJeSwdXW4HcnwIM4
        lFY2aM+S60c9rnfDRG4n5V+SXb5QLHjgeAHzlb/tobNQaqK2J1mNUy2cpBGjWTSJ
        DLvyrfgrcojvlbOqTkaUXVgds6qodQ4aFldN4JYZ04=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Tue, 19 Oct 2021 13:59:36 +0800
Received: from montage-desktop by shmail.montage-tech.com with ESMTPA id pp5001017663793.msg; 
        Tue, 19 Oct 2021 13:59:35 +0800
Date:   Tue, 19 Oct 2021 13:55:18 -0400
From:   Li Qiang <johnny.li@montage-tech.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: can call libcxl function outside ndctl tool?
Message-ID: <20211019175518.GB47179@montage-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Take cxl_cmd_new_identify as example.
There is CXL_EXPORT prefix, it seems can be called outside ndctl tool.
While the intput and outpust struct cxl_memdev and cxl_cmd are private.

```

CXL_EXPORT struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev)
{
	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_IDENTIFY);
}

```


Thanks
Johnny



