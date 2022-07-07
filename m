Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EC4C43334
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Jul 2022 19:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiGGTUy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Jul 2022 15:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiGGTUx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 7 Jul 2022 15:20:53 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C864CE4
        for <linux-cxl@vger.kernel.org>; Thu,  7 Jul 2022 12:20:52 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 66CF021ABD;
        Thu,  7 Jul 2022 19:20:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a297.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C1B6221AD8;
        Thu,  7 Jul 2022 19:20:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1657221650; a=rsa-sha256;
        cv=none;
        b=EccSlY2U8EA9V/F4UunTdfANQjqHtxZetEWDv3qI7zMl93snlV+2MYhKyfTwj81pf56kYk
        WETPQDZ3VELHA6ZVoA6qhMWYuvF8kOOE+4Sj7BUaF5T/SNXnZOODCrjqPqcpunXDaKNUQA
        ZlYRbLaLTDrVMlD5RU+uFIQM0444F0xP8BNZnWVArq5qJjsq16xBpjhQlOFDyV0a4phrfe
        VjAdDymxwcoORC/IfwJ7LUNJ+vZbuuJl+W5JG+eGNrv/SeUXIn17oM1whSthbxF0k07pHD
        r0wRJc05InZADL6StnUgYqGvuB9egonsG0N7o80x4fib2skrYPflOrv9QTacNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1657221650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=96rAmQJcX+yU1fo7pJFvBIyA84njb9Wm+q8jVwCd6ao=;
        b=D+iC1txKXm1AAY0Llf5cAysT/cs12oZRvnbtzehEKlBLv8s2MEDSGwATR/nvUsoOYAHMDO
        qXagckMipM4UldW3hY6ii4Ukjn2sC5qzye/ncHrFEaP3G0adc4joGRsDjut78l8ffBxWBN
        D/T1D66b+46oGZdEY1XyxgODxU/1xxYXop/MuQQWQAUt60zKJbN+XvASGtVZHa840SHGVo
        MSrF89eeYu54Yrq8szI3cAf8AYYeouDuvwl1TLXePoRk/MppggO2he9Co7iGgxh4avWqji
        UXLntSPGxKmUOI8+fmA9mih+VFIDMoFVhACtRzO4BRM2bNbqwj2XBbWTYmfOzA==
ARC-Authentication-Results: i=1;
        rspamd-674ffb986c-6wv4w;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trail-Arch: 6db99b1e5b9091f8_1657221651084_2965970656
X-MC-Loop-Signature: 1657221651084:1829118693
X-MC-Ingress-Time: 1657221651084
Received: from pdx1-sub0-mail-a297.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.160 (trex/6.7.1);
        Thu, 07 Jul 2022 19:20:51 +0000
Received: from offworld (unknown [104.36.25.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a297.dreamhost.com (Postfix) with ESMTPSA id 4Lf5q558FgzLJ;
        Thu,  7 Jul 2022 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1657221650;
        bh=96rAmQJcX+yU1fo7pJFvBIyA84njb9Wm+q8jVwCd6ao=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=F4XPqf6JQYKbe9pZczLK2qPU0TI5vmHubkOFkxo987UkNKHbjWGRxlDHAJ3hPMN03
         B6nYAqNpf0f0XtpGcnhnUATD9GtT9vBfre5LW/k/PR2sVFTDCLZfnXePOFuCghN8Cn
         Be+2SVpqVeyr7kTD7OraJU45VrYEhKPIvugkRRZHM9CT7tnWWxQJ0bOPNRbT1NVqwi
         qJkfzghopM9VvOv2dDDxTXrJUXDmQV6AoGUX4t2PLmqes7lCgwsQ3EHQfvxSdIcDas
         jxGMZr3kBzY2ekFqvqg5u+9UhAejRopHCF9FRPGJVh0PPV4M7W/JWv0Vji36SUrr0L
         wrVCEKRjfvsGw==
Date:   Thu, 7 Jul 2022 12:05:24 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        a.manzanares@samsung.com, dave@stgolabs.net
Subject: CXL device sanitation and pmem security questions
Message-ID: <20220707190524.i2fxgk5ez6c35vw6@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

While going through the Sanitize and Pmem Data-at-rest security parts
of the 2.0 spec, I was wondering if the community had any ideas about
how this would look when implemented. I am not a security person, but
this is how I'm interpreting this stuff.

1. Sanitize (8.2.9.5.5) which includes volatile and persistent regions.

Have a /sys/bus/cxl/devices/memX/erase write-only file which upon 0 or 1
values will do sanitize or secure erase, respectively. In case of the
sanitize command, if this is a background operation, the echo/write will
wait until complete. Alternatively we could just rely on the next sanitize
command to just return media disabled error if the previous one is still
running and not worry.

While this command is running with media disabled state, what happens
when successfully complete? Does the state change and loads/stores have
effect again? Does the driver need to do anything here? There is little
info about this. Similarly, the secure erase is done entirely by hw (both
having no in/out payloads).

Both commands note that prior to using them, "any security applied to
the user data areas of the device shall be disabled" (or unlocked for
secure erase). Is this referring only to the PMEM part (below)? Iow,
get security capabilities would need to be consulted (for the
CONFIG_CXL_PMEM cases)? Or would this check be done by hardware instead
and return error if the security requirements are not met?

The cxl cmd would look like:

#> cxl sanitize mem0 (alternatively pass -E for secure erase).

2. Pmem Security (8.2.9.5.6)

Will this be along the same lines as what nvdimm does[1]? and have a
/sys/bus/cxl/devices/memX/security file that multiplexes the
different security features. Alternatively I guess the above could
also be done within the same security file, instead of having two.

The cxl cmd would look like, based on what ndctl(1) does; as well
as the -m master option:

#> cxl load-keys <params>
#> cxl setup-passphrase mem0
#> cxl update-passphrase mem0
#> cxl remove-passphrase mem0
#> cxl unlock mem0
#> cxl sanitize -PE mem0 (passphrase secure erase)
#> cxl freeze-security mem0

[1] https://www.kernel.org/doc/html/latest/driver-api/nvdimm/security.html

Thanks,
Davidlohr
