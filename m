Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C29BC46467
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 15:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjAKPu0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239364AbjAKPtx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 10:49:53 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1002A32EAE
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 07:49:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h16so15471145wrz.12
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 07:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kx+2PZuL7bFr6pO8WocnRiw9rL7dEOWCj9OvCwcs8pE=;
        b=w4c8VsJcrRYnU9CnL5i5kAdkMGao5vgN1BHAT2pyItUKlaOT5BCrNcLO/2I5//YRKV
         lOF2j+7NvgZPbT6hsYwgugWMqD4V0xlsENLfTgMCYid+U1Vj4sgHCnieGvIsQtC7NzY9
         SnrACV+ndCKc2lrEO9dceVIe+NAkVj1qQd0S8CUTxIXqgwVWlWnV52ZtH8KizRfGIKAa
         o1GEntZaAiQ/mE6J+ussnZWENtigREHk4HiuYc6iCuRiO3gBvThJgcRLkapBfG0+1Qpq
         sDrQa1Fs8+9TBHAlFsdhrgvcRoGk9rVnhz3YYHbBQ17Jlmu1wNMEK8U0dGyhN0/Ct6qa
         po7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx+2PZuL7bFr6pO8WocnRiw9rL7dEOWCj9OvCwcs8pE=;
        b=H/qdK9OZ5vIKbUYEUC4Fql9voD/J6Jumq83xUEJakDzqXmrjrMAbe9ARQnh5r655Yk
         gs0jt8mvmtogEie0/bDGgNxzRwFN2IFDbWCnGtHLF8GtJXU8ha9bdY5xny4rDMDeVd0P
         Ocnu/SBRorDjya6dlEoc2Sod7veAq7nhlTnb/2D56fcj3rHmxKtX4MRAt1rAg69zTZGQ
         oy/rvF70CjNpUHMaIzTix4rWDohPRu3H02FUGZxffBdchROb2CebTAPsiWswVBORZs1v
         gAIG/JHu8qhVjAZAf9WLTiHye7T9vWGiJEWLHzGL9641PSztswuaQ5kmfQVs0i0Ef0T9
         4oAg==
X-Gm-Message-State: AFqh2kqXgVRqtd1BGGmEChd5p6r9MQaZcIj6o8VlR5pXUhglGEd+mEZ6
        J9bsjOCvnXUEdUycIkcSSY8rAg==
X-Google-Smtp-Source: AMrXdXul+AB6ToQixj6ikqTMGn3v0zg0TZP5f/ppvrfkzZlJygOrcGx2TnWGlAVtLBcxhWdZcYn18w==
X-Received: by 2002:a5d:5346:0:b0:2bd:c499:8f7 with SMTP id t6-20020a5d5346000000b002bdc49908f7mr1595323wrv.27.1673452184630;
        Wed, 11 Jan 2023 07:49:44 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d6686000000b002bb3229a03csm13010875wru.34.2023.01.11.07.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:49:44 -0800 (PST)
Message-ID: <68f9b74a-b0e7-c5a6-7b99-ce4f96d79f36@linaro.org>
Date:   Wed, 11 Jan 2023 16:49:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 6/8] qemu/bswap: Add const_le64()
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <20230111142440.24771-7-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230111142440.24771-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 11/1/23 15:24, Jonathan Cameron via wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Gcc requires constant versions of cpu_to_le* calls.
> 
> Add a 64 bit version.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/qemu/bswap.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

