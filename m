Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8BCC4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 17:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A37160EB5
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 17:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhHKRk1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Aug 2021 13:40:27 -0400
Received: from server.avery-design.com ([198.57.169.184]:48288 "EHLO
        server.avery-design.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhHKRk1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Aug 2021 13:40:27 -0400
X-Greylist: delayed 3820 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Aug 2021 13:40:26 EDT
Received: from 50-201-210-206-static.hfc.comcastbusiness.net ([50.201.210.206]:61952 helo=smtpclient.apple)
        by server.avery-design.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <cbrowy@avery-design.com>)
        id 1mDrCh-0001sN-F3; Wed, 11 Aug 2021 16:35:43 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: CXL Hot and Warm Reset Testing
From:   Chris Browy <cbrowy@avery-design.com>
In-Reply-To: <CAPcyv4gecCFVDeV2VwoaNwqycqkHNdKZT4-4KkcqLEbQ9RBsmg@mail.gmail.com>
Date:   Wed, 11 Aug 2021 12:35:31 -0400
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DA610719-EB4C-40B5-9F53-26760E3BE754@avery-design.com>
References: <20210811194747.44688-1-johnny.li@montage-tech.com>
 <CAPcyv4gecCFVDeV2VwoaNwqycqkHNdKZT4-4KkcqLEbQ9RBsmg@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.avery-design.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avery-design.com
X-Get-Message-Sender-Via: server.avery-design.com: authenticated_id: cbrowy@avery-design.com
X-Authenticated-Sender: server.avery-design.com: cbrowy@avery-design.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Dan,

Wondering if you could shed some light on OS orchestrated reset, Sec 9.3 of CXL 2.0 
spec.  How is initiated at OS-level?  I tried some conventional approach or using sysfs 
remove command on RC and then setting RC bridge control secondary bus reset (using 
setpci from Ben's pciutils) and can drive the system into PCIe host reset flow (LTSSM 
Recovery for hot reset) but the CXL host is supposed follow steps in 9.3 including to 
send CXL Power Management.Message RESETPREP REQUEST to CXL Device 
before all this.  None of this occurs.

I’m testing on pure QEMU emulation as well the the QEMU co-sim to real DUT.  This 
work also serves the needs for the CXLCV test software.

What is the proper procedure to test this from OS or user perspective?  Are there sysfs 
entries or other commands that are necessary for CXL compared to PCIe?

Is there something missing in QEMU CXL host bridge hardware point of view 
to automatically generate the VDM?

BTW we want to work through all the reset and power mode testing so hot reset is just the start.

For us the QEMU co-sim is a good approach for pre-silicon verification (if we can get the host 
part right).

Best Regards,
Chris
