Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF4F9C4
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jan 2024 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMKLZfPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704200644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V7AwIig+ZoWr8wywEFVJNnQ4USsekIWlyGOcRxRZ22g=;
	b=aMKLZfPrBf/wlkJiW7IpD1XzQN5gakwiXTqVWRto93XhFBmgVrbk34KmthKxxKevdD86WL
	uRSy99pmIJp8Tg8a5cF7c8/79glH2VMWMttOqv0dK+2v3MWIXckWHpx5kWW5f+pWQ8LO3z
	1CBfkGLL+7MLslIjuSqqmPJ/krH/w24=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-StyqvVxjNWGL_0oCjbd0Pg-1; Tue, 02 Jan 2024 08:03:58 -0500
X-MC-Unique: StyqvVxjNWGL_0oCjbd0Pg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40d27ea0165so85999645e9.1
        for <linux-cxl@vger.kernel.org>; Tue, 02 Jan 2024 05:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704200637; x=1704805437;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7AwIig+ZoWr8wywEFVJNnQ4USsekIWlyGOcRxRZ22g=;
        b=eY0/gRl6aI9fptckLTjSfPxFQccSu+H0KpXnkMdo3P6oqIJ+0E4mvfO67C9vfgDHhn
         3K7ldhhJhrxMpqCEZv0CoRK0bk3TX7s6whDjW+OWqXdZEzjJIFOVR74dBGHohNI6atKZ
         ue7My3ffnAKU1cZ+RTdG6jS58wheKPTAPCB7Nba6e5kFRssO1anifOi0f4dIKnSG/0Ot
         bYCzNGXTuIQ79wLqkLwBkHyW/rDCEW6ERXPnciG/SYKI+vClsyeGJCOmA9xlkmHb0Qv7
         yWekzrAD0+yLQHdFmAVXcJLAOjmnllZ9TSdJVys4oY0YM3MVaHIyiLgfzqoxDteQD7Cf
         C78Q==
X-Gm-Message-State: AOJu0YyysVljxEOJNGPuoF8s82Ps7w3Yx9v/gS4g9TwcLLcC2eDW62QC
	9vvDKhmmEf618Vu4WzwHYnJA/xkJ/3hFMFB2tYdk48OxLjuXUtbSJKad3DyGvL+yeKMRXc5IxHk
	khh9BSIazFguiSDWHNW+YsSHDA9h0
X-Received: by 2002:a05:600c:1e8a:b0:40d:8e0e:7c9b with SMTP id be10-20020a05600c1e8a00b0040d8e0e7c9bmr123462wmb.106.1704200637395;
        Tue, 02 Jan 2024 05:03:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFAjmBcQVT872jzcwjf9S2r8cje/ey3h55ltl8/gm52PrMR8bYxAKdvg8tXqCJPVbYXn9vsg==
X-Received: by 2002:a05:600c:1e8a:b0:40d:8e0e:7c9b with SMTP id be10-20020a05600c1e8a00b0040d8e0e7c9bmr123440wmb.106.1704200636944;
        Tue, 02 Jan 2024 05:03:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c713:ba00:5d06:97c4:3fb1:e21e? (p200300cbc713ba005d0697c43fb1e21e.dip0.t-ipconnect.de. [2003:cb:c713:ba00:5d06:97c4:3fb1:e21e])
        by smtp.gmail.com with ESMTPSA id bh20-20020a05600c3d1400b0040d8eca092esm50460wmb.47.2024.01.02.05.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 05:03:56 -0800 (PST)
Message-ID: <3ecd3b5a-c4d3-4fd5-b75b-d89b1d4b45e5@redhat.com>
Date: Tue, 2 Jan 2024 14:03:54 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem: qapi/qom: Add an
 ObjectOption for memory-backend-* called HostMemType and its arg 'cxlram'
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Widawsky <ben.widawsky@intel.com>,
 Gregory Price <gourry.memverge@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 Ira Weiny <ira.weiny@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, linux-cxl@vger.kernel.org
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240101075315.43167-2-horenchuang@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.01.24 08:53, Ho-Ren (Jack) Chuang wrote:
> Introduce a new configuration option 'host-mem-type=' in the
> '-object memory-backend-ram', allowing users to specify
> from which type of memory to allocate.
> 
> Users can specify 'cxlram' as an argument, and QEMU will then
> automatically locate CXL RAM NUMA nodes and use them as the backend memory.
> For example:
> 	-object memory-backend-ram,id=vmem0,size=19G,host-mem-type=cxlram \
> 	-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> 	-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> 	-device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> 	-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=19G,cxl-fmw.0.interleave-granularity=8k \
> 

You can achieve the exact same thing already simply by using memory 
policies and detecting the node(s) before calling QEMU, no?

There has to be a good reason to add such a shortcut into QEMU, and it 
should be spelled out here.

-- 
Cheers,

David / dhildenb

