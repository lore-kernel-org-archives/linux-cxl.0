Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E364EB64DB
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 07:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbjFPHpz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjFPHpq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 03:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC822965
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 00:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686901497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHh80tHevfpfGpsYLMJr0xWQFhLc1pRS6PbFj4Uk1xM=;
        b=f0W7bP644MaXlFbQdbU8PiQH3tBJBlEmC7D3ilqoeQdrCx5QDh8xwNFOz20gS/VP0dFLmb
        2D37O5tvwy7xWWaFrtxdayEYTf18VE8nwnd5KSG9a1/u71p7BYRrswI6gceBeYEj6dAnth
        EQr0A1vRbGMhUQKe8SzSlRg7LbWRoj0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-VzTSFw05NKexOmONN2I-lg-1; Fri, 16 Jun 2023 03:44:54 -0400
X-MC-Unique: VzTSFw05NKexOmONN2I-lg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f60dd5ab21so296671e87.3
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 00:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901493; x=1689493493;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHh80tHevfpfGpsYLMJr0xWQFhLc1pRS6PbFj4Uk1xM=;
        b=Lkz0luY0+70JXxfAMwjC0Dls3yy+jiiy57ASKRHtqMIVAwcFyxcEDCUfqDsrQB7IVF
         mNWHgAFg7ORTL05gILrFk/SCE4mq5FxEGgw3E/29FsWsMHQs1YSTtHP5OJIDsU6Fh71a
         wuSH7OsBttmRrpbBOddcP9/TWuOBVXYaZuGVBGXyBr28HnJKhT7sV4JzJFKGibwaXXj0
         +o3KMJUOuphsBCniosnXtAgZ1hbxgzzXRkNBkPziuC9O8digUFA8/G/k4wpSOrDq6iIa
         kZtJs4pvI096YlEi8ZQ7Hz57cIGNQ4ZnLs/gSpDKI5UhZFAuo1L+9Te7gNOYU0vdpIg2
         COtw==
X-Gm-Message-State: AC+VfDyNhL9vgHB9lGCdW9rMJs0x6jkkrTbbM1949+bmHQ9sM9kT7iyA
        voxNfw6h5RSUp4LZoBV88wpanmsSOimTHW+/9RGFHbu8+4cRgnKqtZFKFJCagtmbxI/iZzZ81UG
        p8e3g1yiHhVNbIRKrbtx0
X-Received: by 2002:ac2:4d93:0:b0:4f8:4961:7610 with SMTP id g19-20020ac24d93000000b004f849617610mr755641lfe.43.1686901492815;
        Fri, 16 Jun 2023 00:44:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4V2KwN13A0iu+AAg7e0iRwh6yMnxJrHrSMfwNZ/+rksVbEc+zvz9ZHK23cYpe/zyiH2IoeHg==
X-Received: by 2002:ac2:4d93:0:b0:4f8:4961:7610 with SMTP id g19-20020ac24d93000000b004f849617610mr755629lfe.43.1686901492450;
        Fri, 16 Jun 2023 00:44:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b002ca864b807csm22936582wro.0.2023.06.16.00.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:44:52 -0700 (PDT)
Message-ID: <29c9b998-f453-59f2-5084-9b4482b489cf@redhat.com>
Date:   Fri, 16 Jun 2023 09:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/3] mm: use memmap_on_memory semantics for dax/kmem
In-Reply-To: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 16.06.23 00:00, Vishal Verma wrote:
> The dax/kmem driver can potentially hot-add large amounts of memory
> originating from CXL memory expanders, or NVDIMMs, or other 'device
> memories'. There is a chance there isn't enough regular system memory
> available to fit ythe memmap for this new memory. It's therefore
> desirable, if all other conditions are met, for the kmem managed memory
> to place its memmap on the newly added memory itself.
> 
> Arrange for this by first allowing for a module parameter override for
> the mhp_supports_memmap_on_memory() test using a flag, adjusting the
> only other caller of this interface in dirvers/acpi/acpi_memoryhotplug.c,
> exporting the symbol so it can be called by kmem.c, and finally changing
> the kmem driver to add_memory() in chunks of memory_block_size_bytes().

1) Why is the override a requirement here? Just let the admin configure 
it then then add conditional support for kmem.

2) I recall that there are cases where we don't want the memmap to land 
on slow memory (which online_movable would achieve). Just imagine the 
slow PMEM case. So this might need another configuration knob on the 
kmem side.


I recall some discussions on doing that chunk handling internally (so 
kmem can just perform one add_memory() and we'd split that up internally).

-- 
Cheers,

David / dhildenb

