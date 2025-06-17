Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DC289839
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153044; cv=none; b=PrY63Vmeyfz3Z3t+rVWyLND3pwyiP6cSmqawrzfw8/enqy50YdfMMfKU0507H4W5zsGbHldQESX24ZEm7dJnrb/+Y/File6h98Q8lzZ65KPmOBnzR/tgN2dqbBPkluFPBs7QRVcARJfmkHaWnUmPglLzpbPNAJHDdIkj3LaXLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153044; c=relaxed/simple;
	bh=aLrgdQZSb4Tg33mZZ0YCaNA7yWG9NOovoj46L7LIZFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLGj5yIO6Tt/50FxkhSWzK94Qu6Ptp8qA76dBjxc4NSwEcpzCM4t1vTIghbu9jYYxd9OnANimjRDshoIYy/sQHMjst2FWdVzSbQLEpPfp+JXslkSKKMRBfNgNeQXSVYTZDWjTkzRyoL0zAG7sxQ77A8wpIN1CGUJaVQVHGn1BY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXvpZU/G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXvpZU/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750153042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0iZWBl/87jpgBtc7g8vCiBj8fMDtEnqMgq5VqeHe2b4=;
	b=cXvpZU/GoIIQvNunSyBw6x0ESa0YB7oRzbBWh6+1kU8r8CY0k65D+ZLvSl5tSnPoxcps/s
	V6a05b8f7bmr6XSOXA/hid1HpwqDgAhgqP3ZyKR8R5SGdqKSKQBIfAwsAnM/yWvAOB5Wld
	xWB1JwxXlWOT/SMO6rJXuaEHVfnHYV8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-mTCIqkviPXaWNhyeNWFKMg-1; Tue, 17 Jun 2025 05:37:20 -0400
X-MC-Unique: mTCIqkviPXaWNhyeNWFKMg-1
X-Mimecast-MFC-AGG-ID: mTCIqkviPXaWNhyeNWFKMg_1750153040
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a579058758so1010863f8f.1
        for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 02:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153040; x=1750757840;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0iZWBl/87jpgBtc7g8vCiBj8fMDtEnqMgq5VqeHe2b4=;
        b=LDYJ1FOl1OpEjbegQfjE98i7THuzV3N61jTSREyC3tVnj5b28T334uUAm5KDr7cfBE
         a2euRJcPhOUsJ9oWKzrN47/NkLU2X5x75b6LLHJ/rDZg4B2NzTa0k4QuH2eHOnYbJgDO
         wV9UcY1rNLZvg7GrsQ0iGeOK9yeo8EfYkN7SL58vNA+G2UlKgyVuWoS5lAclhi+UyJgH
         SibeBQCSXgNB2kh1Yc6SzLQmJ0U+2jSgfGyUZbwdoFZ0aZQBbkkzD/hDBmdPKaZvWM+Q
         TXuHVBkVn5upUJIDKtd21oXGUk73+oLQR7/JtvcNhScf6mDHU5zF08SNWDaA2ymgMOcf
         ldew==
X-Forwarded-Encrypted: i=1; AJvYcCUaqTiEp+T66T6IQDyAa12LmY2CUXnynA4weEJST3XPw1LLREB7LbKb9+KwXXNHuBCU7YZLfPNzLbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUi/vxrO00N/I6g4g63cg3ZhgbQtkR7mDN0JstI7ZADwHJQIqk
	cqVrB7lt909L66XeS1PhbTcZJqtPv7xaoQwT71FToT26m/dUftzQxizm3qP8XPQ6aP3gE8CoO90
	Ngr2pxQlYRda0xH6YkbtZ6RaP1ScoZxOM5IMa+XpulIoBMc6dr3LeQSZYS62npQ==
X-Gm-Gg: ASbGncviTF1nLDYeQF6U3FjTPJZTcBa7h/MBpFD7UKQ8v0KpMhmCFQLKJXxhgKFeDce
	bdwwDQPEbOwBUVUfRaw2O9WNtsyldvTlyAHF7oYwltBYcysjDgwpKe59FKLh+Sk1zohGVAsMJqQ
	8SLVAw9FnHUTxd+4bQSICwluXlo/WI0O1V5vcVsuEMbytIU1qljMDO34Ru24iIPA4mIlnzOGwEk
	AJNNRD/r3vzPvx5K+ifC6t5SXEIdTmxeobPGMSRGnQJkSfZMutMDpP8tL5QSVXzsOJGjQom1gX3
	BmR2vm3XhCf3ABO29ryb0Sk0HbGDsCnNZwHFearlEjzVp2xkxvSL2jiiZPDLQMawEDGiJ5b0xQJ
	V/1eUaEgh7WrBckLAFAYxbc6hwQNKH3PsBpyUj+nmLvSpmgE=
X-Received: by 2002:a05:6000:2089:b0:3a5:2ec5:35b8 with SMTP id ffacd0b85a97d-3a572398cecmr9501311f8f.11.1750153039546;
        Tue, 17 Jun 2025 02:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn0r2S94rVo2KuanbuIlCONOQLmf7OLS7ZUZs7agOAWDn3Sa7W8ftax638hwNbov3D5qaGyQ==
X-Received: by 2002:a05:6000:2089:b0:3a5:2ec5:35b8 with SMTP id ffacd0b85a97d-3a572398cecmr9501261f8f.11.1750153038988;
        Tue, 17 Jun 2025 02:37:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c64esm175838425e9.7.2025.06.17.02.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:37:18 -0700 (PDT)
Message-ID: <d9fc2e4f-3a4d-4bf2-9a45-b4d890f2b0d8@redhat.com>
Date: Tue, 17 Jun 2025 11:37:16 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] fs/dax: Remove FS_DAX_LIMITED config option
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
 dan.j.williams@intel.com, jgg@ziepe.ca, willy@infradead.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
 balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, John@Groves.net,
 m.szyprowski@samsung.com
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
 <bbade6a3154d14d958f5f9cf65fd6424897ec9c2.1750075065.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bbade6a3154d14d958f5f9cf65fd6424897ec9c2.1750075065.git-series.apopple@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UGmhH6x0Ha_WGeLO0MKEujG5TvHQ4hEzrRMLHgyfAm8_1750153040
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.06.25 13:58, Alistair Popple wrote:
> The dcssblk driver was the last user of FS_DAX_LIMITED. That was marked
> broken by 653d7825c149 ("dcssblk: mark DAX broken, remove FS_DAX_LIMITED
> support") to allow removal of PFN_SPECIAL. However the FS_DAX_LIMITED
> config option itself was not removed, so do that now.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

