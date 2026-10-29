Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257942;
	b=b5pBZea1OVFaqt/XJC5QtCdOTxIFWAiaoMrvw7cDD/KjzyWI06zEoW04wG+M0cGcfH9D
	 FfgU9onm3eZw0w0ilI8pwQV33O9hiaYSyakcpg8e9Wa8d3e5TH3UtaZyM8cwtl9350tfZ
	 emrq8qJiKhKO+kj7MGz9YgHizxrO9Ag43QZl1OxDdeOHaHgonzFn+ecKIhcseFrgKLQ9A
	 zroPuEHdYZPANnDuUfK2KMwHWgRvEfNSzKuRNllPKbMuluIZBen/V8gM6m5jZUcQ0qP5A
	 22IUZUxtTbJRqiuSwQWXp5Xj+8qZeg+rKBE08zRXfSVd+Luw4GF/1ux66iS2NA4ygqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=q3Nd7r/hqjSFpCyfHdGuJldUGtTV8w8XJqRuLAQWCn8=;
	b=AH5KOOhGfpdT4NDNOSoEi1WnSfOWTRmoFJrp4sGVKesSpXdYyKPd96xvielNYU2ZFy4m
	 Zj94GAAFerN6K4YPq7fIdSDDNoQo8EBMvdPdEpMbfaegDPjnwFHTAmDA/BwM+hZ/CJsPO
	 5GAWmDmGyNfWMOdkajRqJOfeQ269RJcSQLQi4CZ4z2udHaJYAzD7cYiZOKVb2r/s6zZL8
	 y0Jt8NxtWMFTofXTudifP2mR3IUoxNKh+N8iZSJlDn0LiEjDQy/LCIbHgePAbARdZHmKj
	 SjPbJY3TtwPJejh5IiilxyaAH9DWwU6zvS5ipOJLuZSLPQx5M6dD2iP4Kg6J9U25aNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GvVcgnyn;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F4606A31A
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 07:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 911F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GvVcgnyn
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1437953a91.3
        for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793257937; x=1793862737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q3Nd7r/hqjSFpCyfHdGuJldUGtTV8w8XJqRuLAQWCn8=;
        b=GvVcgnyngqdsNPwyskdRKlVlUbkrSTdOPrGYxMZAS2S/XScGHofnWSOhMduYvMis+3
         VnB8W3g3vQn3VyeOVMepuFtITdcQ0uLQLVxEaHLRiXoeIAN0lkeaEI4LdzO/n0ObRIPy
         jHiTgJmGBlFTpi83NHQUadPadCGf/3gn8/nP1ks4Cz5XhAr9jrIlEOeykUzqjAHmHwKH
         TF2FSgb58GssGgItd5ZVpR6I0Iq9PBa4r4PRtme0OOL0cvmUJpn3DjVGMefnCYvwTGaX
         elytMhXW2ATkL1coiHEU2gM3PcMzyzxvY9GkCcaO54+XqIwuiK5ySZqRqyxeCuFurkRf
         jIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257937; x=1793862737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q3Nd7r/hqjSFpCyfHdGuJldUGtTV8w8XJqRuLAQWCn8=;
        b=qcMZIoomLRv/aW7DR5hbmJke3eJpIPOJjbruMEg3abghVnQetoCMIKiNi3sbvba08R
         vdsS9ZMmt9xwRF88qimi78GvA2YUV70xOyeGP+0Q6ZRhpmcQCuMi5yZL83jMTpNaRc+p
         c0CKmHgNktkuu2pqBwpvSgrk9aSnYKw42zrDBWTZ4w4QLRmM4i6dZvXE5fE4BjpP+IAv
         HDJ03nmcl3GGjzGDRHdI3hSqyU//nzpiw0fmZ1btlW3v1vJxyjc7IYsG1YwTfDQEqzLP
         NNh/0YVOa5vp7bqidHwvSp0pBbIcCA2qeMcKTCRlK75w1g+6O+af0izFIuKlvQpj80TT
         bn2w==
X-Forwarded-Encrypted: i=1; AKwUvBzOUlhstITTCFvW9Javed8HZvp3MA069OwjSfQBRLjAzooo4cE2GzXv47XJBJftDGbkt4X+rJA6fvI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+aOVu2NwfkWNjqlFDFpAkJDSnZTkAFHhQ/tNn32MnrDXKi2BX
	sJQLac7ABIL4u1WoATBKVmNHiGP8BLvxJGLzI4SacqjYnWWzA85DxO90
X-Gm-Gg: AYBFou2eFM1h/D9ojVLwgjvcyXSBTd9KQ07uJl+hH9Z+eisW3KfMb6CHYCm30DMEHgG
	tK+cEWwIemQgEVSKVHjIAPm1/CRU32sDF0KzzJt76EnyD+vES6BJpoynAAomAprltu5Ka5lbmS4
	0O4vyxv8j12RArR4KI8G85nNVYh44j2YV043Elu7iCekEP9pkgsylFEBsJoX587AOWdvc24jU+T
	5xdlvaqTSMUQxb2iXKCoUv+cgW5hQaSi4M7GELvUymQX2McCL+4BbXMQMoJq6TGrZJrnJFmdBA7
	C318IgcS9cqhyVAgYnVoCl0U6A7hbPlSKwXm/qALod4fO63P2q6D4pEoXUOTL639chIMU6AaOKe
	v3K/s/zK3OGyx7lKoRiFIrRAEji8ovP53TKV91YExX+r1G9xWDg5HILAF+Vilu5DEtPBY8QETNt
	96vqzl/fXHOSoRFKqilLsffeQ09nnzd/p+HxMYQFw0HFHlwyqg1qEEwqK1sn4zRXDKvesln8fpU
	x5Ie+UGOsX9Nf+qFloKuQNqE1fMhPbHLPDRYtlZW1lFn/EQk2/m6bg5JiUopfPzJ3i10MW8PShl
	7UVQO00apkpp0jH1xzI6vbUXhCqWLtHoSJ7H7CDhKuqdalzQT1VoEw==
X-Received: by 2002:a17:90b:3c8c:b0:3a4:ca46:8d44 with SMTP id 98e67ed59e1d1-3ae5819e58emr3799149a91.18.1793257936864;
        Thu, 29 Oct 2026 00:12:16 -0700 (PDT)
Received: from localhost.localdomain ([101.44.96.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6f01e8a5sm1180018a91.0.2026.10.29.00.12.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 00:12:16 -0700 (PDT)
Sender: Yilei Zheng <trilithzheng@gmail.com>
From: Yilei Zheng <trilith.zheng@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <djbw@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 3/4] mm: add shared read-only vmemmap support for FS-DAX
Date: Thu, 29 Oct 2026 15:12:06 +0800
Message-Id: <20261029071206.19059-1-trilith.zheng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2E5C10CF-F3E0-4694-965C-B0E432A1A962@linux.dev>
References: <20260903122128.12264-1-songmuchun@bytedance.com> <20260903122128.12264-4-songmuchun@bytedance.com> <20261027065723.66564-1-trilith.zheng@gmail.com> <4c9741cf-ac62-41d4-9c7a-7d5ceea4a8e1@linux.dev> <20261029030511.12004-1-trilith.zheng@gmail.com> <2E5C10CF-F3E0-4694-965C-B0E432A1A962@linux.dev>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I forgot to mention the tool execution case in my last mail. Those
microVMs start, run a small task, and exit. DAX is there to save
memory, but the vmemmap is allocated for the whole image. A 2 GiB
image pays 32 MiB of vmemmap even if a microVM only reads a few MB, so
for those microVMs the DAX setup can use more memory than the same
image on virtio-blk. That is also a case this series fixes for us.
