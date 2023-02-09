Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979CDC636D6
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Feb 2023 17:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBIRbX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Feb 2023 12:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBIRbV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Feb 2023 12:31:21 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82322144A6
        for <linux-cxl@vger.kernel.org>; Thu,  9 Feb 2023 09:31:18 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 63C19541F2A;
        Thu,  9 Feb 2023 17:31:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a221.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BDD69541E29;
        Thu,  9 Feb 2023 17:31:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675963876; a=rsa-sha256;
        cv=none;
        b=C+slDbbyM1EWAguRMCltKpEUAIlRnrYZQr23vAJg4B72Rz+kdQSUzK7g95leV6moGGFdEL
        O9NHkbULdi6UA6vTxB7kLwMyzEMZWDDmlR+h9sSryLb82cWP8h80dTLH2phgquYn/wBt73
        n/RYUAKIqauOeLiTwMLn0tX6HkU36TIvJLdGrHUn3Hp6X6ivNyCm2CTvFfZHXSEMIZKSxY
        z7IvuawV8WHDwkYR8Bus/6l9DAeQhNo3qjQkNA01LHu17eQywDtg7walNVJR1+hQ4TAuRz
        zIN3IIRF1WJ386uz9+QcscIkRBxb/pKqEjuCB1vS30+pUo7G5j56OybmMNzG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675963876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=lu/jexLEIZOhV+AK0Xpqi6Lx/OTah5jmVzyDbj9D71E=;
        b=k6WH+OjaL+j+E0XlFkymAnEiuLSwH1aLWzn/9cBg8aEhccsjM2XFlrTNVHT1lgwP/YjbeL
        xR75Y51yVD7Tg8TXJUAYUC3zwczB0vOEkxKevduihr0dctZGJPpf6/2YxLuy1fyj2kwkgs
        xVkZLGczSQyreJ3YD3kpPYTqF/D4k/+K32M6AU1m0UFVuzmtEyVM/mr8ESsw9JZMdc0ib8
        1bCE/4XL7vnAczzHMTUH1n5gOjscsbE2FkUHmA834IAPmplz6fPS8VxXbDdNY3DF30SYn8
        ZyQpmqyM0VPv9z+lLsyOTmOl/vcA5WGqiowPBW7KC4LhIfmYUdHOTHXTPgkntQ==
ARC-Authentication-Results: i=1;
        rspamd-5dc9c5d4f4-j8vkm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Inform: 27ce2c12321f2c33_1675963877181_437059248
X-MC-Loop-Signature: 1675963877181:2973693784
X-MC-Ingress-Time: 1675963877181
Received: from pdx1-sub0-mail-a221.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.134.100 (trex/6.7.1);
        Thu, 09 Feb 2023 17:31:17 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a221.dreamhost.com (Postfix) with ESMTPSA id 4PCP6X1WlLz1D;
        Thu,  9 Feb 2023 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1675963876;
        bh=lu/jexLEIZOhV+AK0Xpqi6Lx/OTah5jmVzyDbj9D71E=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Vx4QasKgg/w+lwrH7oByxhjoHkDLnd+qZMlpeQfW3wQZbOEGB07BCVphJIsUzLgbI
         s3zJQ7xFRN03cmoQWp1gtQOw7+xHxFpFANx69dyVc8RFeBFnOTsUz3Jo8BwXPxxxRJ
         ICLxVz86y/6OdQzFrFE4I7QHINJX6oMKaGX8w55VmBhD4yQapDxGhohNkOywnGZHJI
         EO6QE2mwMUiafeb3pcDTnNufpB5jEMVhw9Orb3awutJz+G2lS+en4W0bX+U03orB/v
         4WUSwjfsXjc5mHFkkEefGKT/CeXoyvkQHEfe7IwNDKMa6PwfNgukTB86gZfZInRjcK
         GfO3BPVWeQSkw==
Date:   Thu, 9 Feb 2023 09:03:39 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mem: Correct full ID range allocation
Message-ID: <20230209170339.u4la2tyjh47tijy5@offworld>
References: <20230208181944.240261-1-dave@stgolabs.net>
 <20230209154518.000011a7@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230209154518.000011a7@Huawei.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 09 Feb 2023, Jonathan Cameron wrote:

>I'm not sure I follow the smatch error always applying, but definitely suspicious here

Just to be clear, I don't believe smatch (or any tool for that matter) ough to "always
apply". Smatch is well known for having its share of false positives.

>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!
