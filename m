Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CE6EB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 07:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFPHr7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 03:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244032AbjFPHrx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 03:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A5A26B8
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686901625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U5bYwqNSLrXJiQtrIMo72MYJh3QZB8KMtEIiq6QD74Q=;
        b=KsC/g3qgFoJi8RN3nFiraOqfssX1lvCG3MWrUzj4I1wZm9dkVrhGU1tsQs6gCq9S4RKY73
        tuUsgacf+Uv5C1UnGXUhxyIWBvksIGL/J8ej6IiNrppAiYTsRcFpp2KHqmpAoOXnMeGFsm
        Ru78BdkLe77B8nkJDJ9tNRq1D81zepI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-FxCOV35AMHGZxTHCoP1sDA-1; Fri, 16 Jun 2023 03:47:02 -0400
X-MC-Unique: FxCOV35AMHGZxTHCoP1sDA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f8f9b50f17so731785e9.3
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 00:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901621; x=1689493621;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5bYwqNSLrXJiQtrIMo72MYJh3QZB8KMtEIiq6QD74Q=;
        b=FxsiDoDQfdopK/WO0sTwgcHbAQ2EWAY+cklQ1XNsycMUEXkVDRXKiviUIFELC8/A5+
         UAlrtcpHJ/AD8hqpfrN4wXvRmMZEbGgiTmwxVoAGk2fdbC3pRraXiUflUx5uD++dka7S
         AKs+usRdVxER74whFC5UqsDs0oVgkHhu09AqWGUlnUGQLvkEqDh+AQju5Y3GYpTJm4jN
         Yx22/4hI2/kA7JOEu4EyVwxCFSPcG/kPwT7iyFa8exAfNe7H9wxgghlbynIJuzsTShbh
         3lN94l9qOA4ANIWA0yQI5nUn3PFqK2F5R94aGyElNrQLl4cn9VLal4DY26E1zUGuBldA
         B+oQ==
X-Gm-Message-State: AC+VfDxyPJGSMaSEp4SyGqZal7WNDRp73K/XNtQGusL30e77ZLTmbOt2
        VX5LxGMxoJqgJtvVKe5WDIzfqjR0Ei4va5YnYX/Rav/BhKaXmCxeLSZv0rOBvhRhUEORYtak7OV
        wUvyS1aJOzArIdA0LflLj
X-Received: by 2002:a7b:cd98:0:b0:3f6:766:f76f with SMTP id y24-20020a7bcd98000000b003f60766f76fmr925946wmj.36.1686901621069;
        Fri, 16 Jun 2023 00:47:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FjFAGg0EAY/fN2yFOMKdsON/pGAcgKV47j+V2XrsGwOYGSddhs9zmuejwHx2MuQTEuN5LJg==
X-Received: by 2002:a7b:cd98:0:b0:3f6:766:f76f with SMTP id y24-20020a7bcd98000000b003f60766f76fmr925931wmj.36.1686901620728;
        Fri, 16 Jun 2023 00:47:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003f80946116dsm1356132wmb.45.2023.06.16.00.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:47:00 -0700 (PDT)
Message-ID: <0ea4728a-8601-bf75-1921-bcde0818aac3@redhat.com>
Date:   Fri, 16 Jun 2023 09:46:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] mm/memory_hotplug: Allow an override for the
 memmap_on_memory param
To:     Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
 <20230613-vv-kmem_memmap-v1-1-f6de9c6af2c6@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613-vv-kmem_memmap-v1-1-f6de9c6af2c6@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 16.06.23 00:00, Vishal Verma wrote:
> For memory hotplug to consider MHP_MEMMAP_ON_MEMORY behavior, the
> 'memmap_on_memory' module parameter was a hard requirement.
> 
> In preparation for the dax/kmem driver to use memmap_on_memory
> semantics, arrange for the module parameter check to be bypassed via the
> appropriate mhp_flag.
> 
> Recall that the kmem driver could contribute huge amounts of hotplugged
> memory originating from special purposes devices such as CXL memory
> expanders. In some cases memmap_on_memory may be the /only/ way this new
> memory can be hotplugged. Hence it makes sense for kmem to have a way to
> force memmap_on_memory without depending on a module param, if all the
> other conditions for it are met.

Just let the admin configure it. After all, an admin is involved in 
configuring the dax/kmem device to begin with. If add_memory() fails you 
could give a useful hint to the admin.

-- 
Cheers,

David / dhildenb

