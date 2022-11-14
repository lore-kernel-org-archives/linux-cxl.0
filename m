Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83CDC433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 19:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiKNTaR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 14:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiKNTaQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 14:30:16 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCF528E09
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 11:30:14 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CC383880074;
        Mon, 14 Nov 2022 19:20:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 258E5880533;
        Mon, 14 Nov 2022 19:20:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668453616; a=rsa-sha256;
        cv=none;
        b=Ne1IveFcfADekSjB1/rYiMiMDqpdKjnwMPBiccRLZ3aHGvndQxjO2HwCylF3UVlsvfjlfE
        R2ccOwkZ4QIeLGRi9e0E6gd2dhiaOgAKGpeA1TqrreY9zdhPhgU/e8Ybijm4UJbu6Ridpa
        RrmtJYUR+zTKmpIjqJhvYuc18LZAZi04TWpvNPvKs6CUO9EtVcRkdCq59S2S07xG9/zaRg
        0qqVmSPN/vVg+Z9NynU62fhuuC6ZfWVD1fMhMVL0a7eMqW4KY/vk0Qa77Kmf/emuWKvOm0
        /MQs3GIvokmheyDtZJxIjtqGGzorgjv/iOgh+hwvByFHGnXMUhtGhdJieHLSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668453616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=gJQIF4DHLl6uR72I07psSEJXqpy7tjvgat+xpJTCYhg=;
        b=83+n3973pgtY4BDIzt2v6HT3i1hDAhKqmy7is1BPUn1FBG5uu0M0RWuWIpiFYcdrF0JyFc
        SoJsTJVe4dD+gepJ25SubPJLy3BTTzVfm1ja0FRbPK8Ry0bwPOScCOISvNZptXaNf+xFde
        4nsUSPErBUwjk+cyL3+11/GSfKpA+s896KEjU2+8J0H7H4OuhIx3nIc1kv2MHKumLIv57T
        darOR3UAFszAmegVbCRqGwhR4mG2qhmrbt1FYt2tTg5vc8icreEth1jjDt1t7u/K+UkX+a
        W37JC5ShcWciLLM4IZjvaHuGCmIK1B9ghTGDePQqOq2ypXum920xgMLr+VAgNQ==
ARC-Authentication-Results: i=1;
        rspamd-5cb65d95c4-ktmnm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Attack: 79a85a49491a1374_1668453616579_3054163854
X-MC-Loop-Signature: 1668453616579:508425783
X-MC-Ingress-Time: 1668453616579
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.12 (trex/6.7.1);
        Mon, 14 Nov 2022 19:20:16 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4N9zfR3DjPz2T;
        Mon, 14 Nov 2022 11:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1668453615;
        bh=gJQIF4DHLl6uR72I07psSEJXqpy7tjvgat+xpJTCYhg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=QyRwurvx0FEmPWCmTfXqJl4oO+RboPWu0+C3wxvO5zVDldUuMjuZk/QuwFO7PdWuy
         N4VmoE+2eFnYwGtDJsmlHMB5v7sEjOqZHaDqOPZHBVGTt6yopbE2DcP15mVZT6GboX
         WQanIq4V+EMBiFUymhpqQmk39pqEmeRSVlN1GJtVLwx2H1Zq41gLsxS3GbM5Pmn/Dl
         YfGN510eNMkekIm4nGLeFH5nZeBJjUQsGlAuiYPA2r6X0uOvVXlHkYmsqP4dqLvw/b
         rxI6kk5JVai/NRRWjVLg/8JhzHD6EfzAImVENKuMHgm0LYPRI86qpEv8tpvQDhlin2
         PtCMx46y5zvTw==
Date:   Mon, 14 Nov 2022 10:57:29 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <20221114185729.nxahgs66ybe2x5mr@offworld>
References: <cover.1668227077.git.alison.schofield@intel.com>
 <37ac2e3d3580af13755edd6f8e0bbdf11d5c206b.1668227077.git.alison.schofield@intel.com>
 <20221112062823.4mrp4kz6hxsd3uxw@offworld>
 <Y3J9NCmVX7t34DYD@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y3J9NCmVX7t34DYD@aschofie-mobl2>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 14 Nov 2022, Alison Schofield wrote:

>The reasoning behind removing the check, versus expanding it, is that the
>check shouldn't have been there in the first place. The ACPI driver is
>responsible for parsing the CFMWS's but it is the responsibility of the
>region driver to decide which CFMWS's it can use.
>
>If you believe that premise, then we let all interleave arithmetics
>'get through' to the region driver.

The way I see it, acpi should be setting the callback because it is a _direct_
consequence of parsing the cfmws, and that's really the same logic as we have
now, in that it sets it when allocating the rp decoder. And that doesn't take
away from the region driver responsibility of choosing the actual host bridge.

Thanks,
Davidlohr
