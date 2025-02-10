Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9887125A2A0
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212897; cv=none; b=hzQELPjSQ3eqJqWKswOSWcPanCYM0QIcFCfSXK4od8KUVmu+rFcKqA1jEIW3H1w3oMFIBauZWfORi0cLga+YQ9hhVQT3Ra9GrhCFjn/YhwS31DHn0GnZdd0fQMS7yQqlXkAs5I8mKF9b8Nk6fotDYB5DmVAfUAdQ8mZaru2R8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212897; c=relaxed/simple;
	bh=bygnSuQXiuOQjyaBUGwyRn+UXTRR8Z74RGWMpAmL/Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5vbShRCFfpg1iRvBfkBFtiFY8zJ07PfW9TQYR2rcnMZ1vNBDuV7kt3lIUfsQNc761hGfg2C8gfgwg/husWrb+xTIWV7rVlbfndPM8oAgiVAcSOIVp6zJ8QboHN9B3ABJX1oCmz8g/2gUnOcErjdQD2CyLNgzAkFwjhAQgh/jpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ad0yqoF+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ad0yqoF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739212894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y5Y8uzPh19Vq/79ybTl3j5BilFyRa3IBZXW8XJ411wM=;
	b=Ad0yqoF+ogazoYNiXpDvxDbIlhthlLNdbUQfDsiu9QQOgdNGzqAfZ6pXLhp8Yfz8oAcU2w
	4EL3I+FcKD7Hy7QJYw6DcBRqp0q6Znh/x37gloBFEa8LbszpTTgudNsQJCp482crF6/UjZ
	iK7kCOlb5iEUIRTdjPBd56JuK3+/QJ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-RCYc6BPdPkuootNCPGYYPg-1; Mon, 10 Feb 2025 13:41:31 -0500
X-MC-Unique: RCYc6BPdPkuootNCPGYYPg-1
X-Mimecast-MFC-AGG-ID: RCYc6BPdPkuootNCPGYYPg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38dc88ed7caso2032864f8f.0
        for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 10:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212890; x=1739817690;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5Y8uzPh19Vq/79ybTl3j5BilFyRa3IBZXW8XJ411wM=;
        b=q3UHAc+05LiqYawL0/GJcqvR61BSsZsZDO0zTKRA10/zkXmpaVIpzzGiLOxV9/Meyc
         dB2RcBzi4z+DN03WIm+K9zrEqB8ueoPkdEl3Rv3AIQOxzJjRBhiG5fti3+OsrbjzVvzM
         yHXWuihnfV/Pp/aef7i9roi/AxuixoPe0O2GWZZtaf7xn39r38QBaqvk8Q9eBXqCHFMt
         +uloPHuHINXqKX0py0A2maAR8q8um+qzezxxU6qxDUmLPVvrD6BSdb0W2t2XXLWRexPx
         gdUcnlpk6nvMA1L/oPj+FfE3U/uthjPUNnEaHf4EhMoQFqQ0WNH9kwUBPeQZdSbs/6ds
         66Mw==
X-Forwarded-Encrypted: i=1; AJvYcCV6ta5hmEcuAscrQs0/U3lJ8Yzmz1iwocPV7Tz6GV+NJESzJKjuuH4aZ6oXu3VLjVsqobLY1rypcBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Tf8CP5AkjHayd7unxbAuuM8lrUqgusS8TSZmWCJEK0pWAsSe
	32gcj57nKQvpCa1n44YmgWQEeYHhEeOv1g5K519o+2+0dGJSgjIOWydHmacB+ajQoWbNm89R3Wx
	7Nqg4yZRo49jzJ99pWSTUZuWUsqtPiDtq0VRCfcbIlOdhqQmieqhzydJVIA==
X-Gm-Gg: ASbGnctyjlb0WmCyIrBBieP3tqFRBTEm7sj4IzwqAOv6R92gD2RgkQLQwziCPIBR07l
	uaE3ezOOjwoXEOTUSJ1ErxzCBl53vfoGdukQLdsZTc675LySCuMiDrzABjTNn5/o6KHTBdqPe26
	sFeGAEdqvwe2xe1BeK2ys5fsrXiwRhPy6PbuZFWAt4PjPOWC02Ubz2POx/skHPcR2HVFesDA9LW
	TZcEjuyDxLhMg/hJRCn/BZrEL4Opiwx7G+pwKSk2JgESr7SPcMGbebq/2vLR1HeNyKV5Hldxa9h
	+1Km507u8HQ8KZRTpMybVKstD3MF2uPusa/rrU+8ksFhMZqxun+AtH9xStgYYn4Q8MbSA6ui8Em
	e9YcRMhgApuHn2dSZGWO/ZGMclAPm7ikk
X-Received: by 2002:adf:f552:0:b0:38d:ba09:86b5 with SMTP id ffacd0b85a97d-38dc935fd30mr8356784f8f.52.1739212890427;
        Mon, 10 Feb 2025 10:41:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjt5GOWnPQL8qWJWzWicp05/2CzwbVpqP4Iexee9A79WecGjReB/qxF3GuYmscVUvKpxlGrQ==
X-Received: by 2002:adf:f552:0:b0:38d:ba09:86b5 with SMTP id ffacd0b85a97d-38dc935fd30mr8356754f8f.52.1739212890044;
        Mon, 10 Feb 2025 10:41:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:b800:12c4:65cd:348a:aee6? (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd34f2af5sm7815443f8f.78.2025.02.10.10.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 10:41:28 -0800 (PST)
Message-ID: <cca05a6f-fbfe-43c9-815b-eadbdcd7050b@redhat.com>
Date: Mon, 10 Feb 2025 19:41:26 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/20] rmap: Add support for PUD sized mappings to rmap
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
 <1518b89f5659d2595bf9878da4a76221ffcfef60.1738709036.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1518b89f5659d2595bf9878da4a76221ffcfef60.1738709036.git-series.apopple@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QX2NwTTq7WNUbACTArjHrCDJ1vzGVGdxnffoVqsivGc_1739212890
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.02.25 23:48, Alistair Popple wrote:
> The rmap doesn't currently support adding a PUD mapping of a
> folio. This patch adds support for entire PUD mappings of folios,
> primarily to allow for more standard refcounting of device DAX
> folios. Currently DAX is the only user of this and it doesn't require
> support for partially mapped PUD-sized folios so we don't support for
> that for now.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Nit: patch subject should start with "mm/rmap:"

-- 
Cheers,

David / dhildenb

