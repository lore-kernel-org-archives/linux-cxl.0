Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED37EB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 23:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjFMXFg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 19:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjFMXFf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 19:05:35 -0400
X-Greylist: delayed 21639 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jun 2023 16:05:34 PDT
Received: from pdx1-sub0-mail-fallback-a200.dreamhost.com (pop.dreamhost.com [64.90.62.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8711CB8
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 16:05:34 -0700 (PDT)
Received: from pdx1-sub0-mail-a234.dreamhost.com (pdx1-sub0-mail-a234.dreamhost.com [10.35.49.13])
        by pdx1-sub0-mail-fallback-a200.dreamhost.com (Postfix) with ESMTP id 4QgZfv0sqwz7dR;
        Tue, 13 Jun 2023 10:04:55 -0700 (PDT)
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4QgZdS6634zCb;
        Tue, 13 Jun 2023 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1686675821;
        bh=LWZiYErxQAk/kdGPiA3UX0Gd8a5s0UNHQhJbKyutoTc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=BXRdikUjdE5l/kpedMgXFE7OqfeX9UfCJFI9e1wx7HHPi+CYwi+c9Z+RFpdgTgvZN
         uhWG3Ni4/JF93fDz828lXHQ8wZTiedifTMdI7oHeyaOklKzS114ddwAjQv+AV+wqwY
         mog5ZIv3OgfRn1se6kxM1vkwmQe0SHG0lx6AgrHydrr7YH47pmWtpsSoVWdJ2kJlPr
         8OCvkxHzRC210aHXTXes3k0/6APQtTdlk46ORE6ujO7bu72mic9miZRq5QaonqSPRE
         SDwyzfsxpBL16gf2BovE7i8tkg71jFPOVNTzoHS/KZD4mNzW0nJYLOkizLnYpxT2/c
         LaP/3ORa38Xfw==
Date:   Tue, 13 Jun 2023 09:28:54 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Message-ID: <giuweh2q6au33ycip6wiz6lf5g4wdhoyawfqoosq3x3atitjet@gtc2a6hzp63e>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <20230612181038.14421-4-dave@stgolabs.net>
 <20230613170755.000011b9@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230613170755.000011b9@Huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 13 Jun 2023, Jonathan Cameron wrote:

>> +		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
>> +			if (cxlds->security.poll_tmo_secs != -1) {
>Should be checking your new poll boolean.

Yes, again sorry for the oversight.

Thanks,
Davidlohr
