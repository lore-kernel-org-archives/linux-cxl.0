Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E39C77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Apr 2023 02:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbjDZCsr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Apr 2023 22:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbjDZCsq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Apr 2023 22:48:46 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546BE1AE
        for <linux-cxl@vger.kernel.org>; Tue, 25 Apr 2023 19:48:43 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 46FD86C1B58;
        Wed, 26 Apr 2023 02:48:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C0CC16C1A74;
        Wed, 26 Apr 2023 02:48:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682477319; a=rsa-sha256;
        cv=none;
        b=h/BBgDtigRdFFWEcV6f6r6DTP9D360/wpasjN+6yBkw1CTjq0vPBjR4uE4PdaO++f1AnY8
        BXUq1E2s6W7xscsFgtcZjLPcf/2svLf0XC+JMBPx1061n2hC1tLvpCjG3mB078hBMCWezt
        zALLGODROYtaGLn3txDbwB1mR2DRWdCF/WBuADsuPqOahChh5PvuSTCuQ3gD0lCG2VWRBd
        ofjynD8JxswwWY6T9VWV/k09G0eik+DnPVcTTmdlnm2S9EIbQQgRvvSDUo9qvAW3UeAMub
        5mn3H2VcOKCzMdtscdNTTFZBhFa2W6zdl7paCFZVaP8h8R5D7MQnnbddFk2tIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682477319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=XXRLr/++NetQw8nENVV2o2ktX9ohnSh7sAXVGuSBA34=;
        b=uhRpWXeXt7ZuPI3lnowDXcZZzAokY4c2mVc2q2kNGWyaC07p+N3s9rpCV/VDSx779fQTsR
        6NHR5swCTrLf3c2HyY4JhO370UqL+z7S4SY8Ud+/Yfhk88nnXes+2GWy26hyil9jEWJTl3
        1Rn5LApS6TUZdv/VTlsqyXDrOtByixhPoyF4wjxxpCj4ai0dj1w+x578+qBg86HFdGwiHS
        S5niTFvIQ95Zn4M3zaQRt9Clpj3jx8d2/hv+z6m3mJI82RvaMMIIcxrYM9eUyDi5IRgul/
        9UMNQVj/LF6PX93JHJ4zFZDU/LSs+aOzGqjDXIibRHs9ENDqqMU/bwYtotpQcA==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-zh2xg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Battle-Cellar: 2f4e31c82f4b14d8_1682477320064_3291818604
X-MC-Loop-Signature: 1682477320064:175389461
X-MC-Ingress-Time: 1682477320064
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.114.243.54 (trex/6.7.2);
        Wed, 26 Apr 2023 02:48:40 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Q5jx317KRz9s;
        Tue, 25 Apr 2023 19:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682477319;
        bh=XXRLr/++NetQw8nENVV2o2ktX9ohnSh7sAXVGuSBA34=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ak7UvqKDEFdF5HMTZLn+95W0Cwy5fgY3Z9nD6S+MoI9wjfKVbwsLJEjGIlUdRhkC/
         zCPaoo66s4oOmNt1AzFKB2UO+hR2duiHExctGKQPoEFntCPxAVTDEq5y8cH38EJHQs
         eae8gif0ARDtvWxTs8bqziV04t2fGDQlp97sSDIflBmOCW2Zp59fIjE1ep7pU+JSnc
         AKoNubOwwGsIRP14KsnZ6B3cTTemJHAVUKHck3e4i4mhykkIymfibyIG+FKmPvS4Fh
         x975PhN/O9Bd/zyXDaHznsxxOngX2yJdBRUOHrvoVuzKBqdEbgk12eYG80opxsBK6j
         +Ml7bKuhJqsrQ==
Date:   Tue, 25 Apr 2023 19:16:54 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     alison.schofield@intel.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH -qemu rfc 0/3] hw/cxl: Add support for Scan Media
Message-ID: <yvyovjxuhy7zx5bwtpwg5owhnz7xozpn5hkxin223ujar5cvdx@gxqxc7j3g63q>
References: <20230426021418.10186-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230426021418.10186-1-dave@stgolabs.net>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

>Davidlohr Bueso (3):
>  hw/cxl: Add get scan media capabilities mailbox command support
>  hw/cxl: Add scan media mailbox command support
>  hw/cxl: Add scan media mailbox command support

The last one should be "Add get scan media results mailbox command support"

Thanks,
Davidlohr
