Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7E2C433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 21 May 2022 09:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbiEUJH2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 21 May 2022 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241597AbiEUJH1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 21 May 2022 05:07:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9738135688
        for <linux-cxl@vger.kernel.org>; Sat, 21 May 2022 02:07:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c10so13334418edr.2
        for <linux-cxl@vger.kernel.org>; Sat, 21 May 2022 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qCtW9rb8rGhJd6K30RuLhTSgw/3fmThEspP/NPQCgXc=;
        b=nuKMJUkpHfayyGVrKvMotpsVxBSt7eCgLVEfqyJnZ4v2++RzwduORI7I8NwsEazJO2
         GkRuI4iDifwdg3tWfBU+WeuS7pF7j4l0a13fWbdm4dFJUvbZS7bsorAEob5POxGpAtYn
         eVICuvVM3Lp7j47Z5YbSDNkRCAO2RVKIzF2xOy3Cha9+ZD1xMuRbPoZM2VRCG45rslGt
         E04yHFzvzHF97xbgLPzNKMYG9DOInEMaS9W75rRhMdcEQzbzec1p4oyDmMH1r1UHlGUz
         OYeFEKgqmfstd+rlRB4NitcB7p+zMEDu4VIKpKWzr5i6h9Ycarp8cX9ym29ksGo1aMbc
         DZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qCtW9rb8rGhJd6K30RuLhTSgw/3fmThEspP/NPQCgXc=;
        b=qF1sl1EtqFKqwuSSMDIPY5Za5gV8RMCHGySp84Ks7nks+oUwfHWLUs/M5u9ZI4CYz3
         8iGI/wsZPZkqxASEpeDt4HoNMVhQH2CWwWxs2YkAPi2YfpkPw65fXreOelPwp7EThkxk
         10dfAadyukip2HNtUITX22CoqG4MlFvMEYHedkoeqyrmr5YuomqeaaoJ14vaPLojMhNB
         Pgdt+RC2zfM4Pr1YD3Huxu2L2C5MQE1XLxchf0fAvbTVKONJKo9tPtkgY3miBNkEjWVE
         DDqIBReCuaiNqCSHzanDmNoq52kNBGtocZHIj9bIUB5IXLEnCw+9QmIPHuWVcQkYyeoC
         5ASw==
X-Gm-Message-State: AOAM53241PVRBy7HTpqwiTtQheT4Hnvna90P28+5Py911DHxV/4YO6aY
        R4K11++TTc+GaOx9AoCFW4s=
X-Google-Smtp-Source: ABdhPJxQvSD/XURWxmbw1MDP3r1D2+JA7dD91BdQBa8/5pUoz7VGGxrkHWoiFj2t8VOXbUseqiDP2Q==
X-Received: by 2002:aa7:dd07:0:b0:42a:eeba:a0a8 with SMTP id i7-20020aa7dd07000000b0042aeebaa0a8mr14817690edv.371.1653124044371;
        Sat, 21 May 2022 02:07:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id el21-20020a170907285500b006f3ef214e50sm3950339ejc.182.2022.05.21.02.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 02:07:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <0c0055ac-8d94-37d9-62c2-58c3da5461d3@redhat.com>
Date:   Sat, 21 May 2022 11:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 27/45] hw/cxl/host: Add support for CXL Fixed Memory
 Windows.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linuxarm@huawei.com, qemu-devel@nongnu.org, alex.bennee@linaro.org,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, f4bug@amsat.org,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>, k.jensen@samsung.com,
        dave@stgolabs.net, Alison Schofield <alison.schofield@intel.com>
References: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
 <20220429144110.25167-28-Jonathan.Cameron@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220429144110.25167-28-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 4/29/22 16:40, Jonathan Cameron via wrote:
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> The concept of these is introduced in [1] in terms of the
> description the CEDT ACPI table. The principal is more general.
> Unlike once traffic hits the CXL root bridges, the host system
> memory address routing is implementation defined and effectively
> static once observable by standard / generic system software.
> Each CXL Fixed Memory Windows (CFMW) is a region of PA space
> which has fixed system dependent routing configured so that
> accesses can be routed to the CXL devices below a set of target
> root bridges. The accesses may be interleaved across multiple
> root bridges.
> 
> For QEMU we could have fully specified these regions in terms
> of a base PA + size, but as the absolute address does not matter
> it is simpler to let individual platforms place the memory regions.
> 
> ExampleS:
> -cxl-fixed-memory-window targets.0=cxl.0,size=128G
> -cxl-fixed-memory-window targets.0=cxl.1,size=128G
> -cxl-fixed-memory-window targets.0=cxl0,targets.1=cxl.1,size=256G,interleave-granularity=2k

Sorry for the late review, but: no more command line options should
be added to QEMU.  This should be:

-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=128G \
-M cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=128G \
-M cxl-fmw.2.targets.0=cxl.0,cxl-fmw.2.targets.1=cxl.1,cxl-fmw.2.size=128G,cxl-fmw.2.interleave-granularity=2k

I'm not against adding a shortcut as above, but the implementation should
be entirely in MachineState using a QOM property.

The reason for this is that we're looking into doing machine setup entirely
via RPC, and any extra option is a new command to be implemented.

Would you be able to do the change?  Since you are already using QAPI to
deserialize the option it should not be hard.  I can promise a quick review,
and I can also provide with an example conversion for -boot at
https://lore.kernel.org/r/20220414165300.555321-3-pbonzini@redhat.com/.

Paolo
