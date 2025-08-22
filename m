Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA92BE03E
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886536; cv=none; b=h9KzMjnuiCFQwqJqPECFHAeVL0eyu1W5MHkW1QBxbEUwRh8d8qXNjGPbEbORa7+XiRk5+se1StjB+h7fSMGd6fYYlgqcY6Ft0PULj+i9HCsSgD+aRrvGA3YWIEZSPY0EXp2VYSBdrDcFHkq9nsNjVXH2lf0GY0+K4s9K2khf6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886536; c=relaxed/simple;
	bh=V94dfA16La60dmKehf08TTEBcoaCXjBACbj1AhKkruU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wq5v5ODFusfHnBrlpioHXXKk21ix/nTFjvxfhLvLYRpMpyYeaejgvPsh0hL+VCseTjcwdwXXjmPzFlVj3OurmYnaNcXcO4cbViPCmgsnBjbnMyAtQQfREg5cUzDhIEtuYP1Im0jTMoJ4r+w3SXMYeOIHmxxkfldcLwUPw5KtEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LBwwXIJ0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LBwwXIJ0"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb78fb04cso320215266b.1
        for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755886532; x=1756491332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYWGWVCN0O70uGnBCPPQFCaIo3hbXhoMScsfqxRs/Kc=;
        b=LBwwXIJ0UcKfsZ6Fn4z7xbi0+AkXaoPoT8WJHBeVUngWegUr8qwNsXZ8FtEJghznX5
         Qi/K2L5EogfbxdnzItAPc9qh4Z9zDbTZjfnUAc3JJ3ysTq/OW+N9Lm/cEwshCBkJ8KgF
         aI0xJdoD6vfoPvKXk0Ztl2JLMMEpXXFPiZdKAkKcmaD0kKJ/zZF8KBJQa3GLqFgcIMZF
         FyBjQJbu4gjGx7Bmj7xoCMqOohmb1v7Tc5+0vno5kYGkEOREWvyoz6U3jmG0njuxeHbE
         n8ojF8pvjXjzpRzSzwHCfiADF/uVH/mOUUj+syX6OpDqbuTx10pi2pRmyot4qbKahSy6
         NUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886532; x=1756491332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYWGWVCN0O70uGnBCPPQFCaIo3hbXhoMScsfqxRs/Kc=;
        b=eF58ZHgzsZ632hk9WceVAveKf+xSJ/vt8DRkB/Oxfi6tASWs9lmaP7I1xw48xwMnA1
         q1uuKwafuW+m5xAwZI5sTuhgJ4euhLnNbiAIl8n8SZ50rp8qsdbSoGk2NpRe/tT8fwSq
         YDNEo6/VxT6Hcb6OAjfkh03ye0VGOgjwWWjutNAQXiOVPfZ7N6yEayOiSdpSRVv5pnMz
         pik7V0oGGpYycz5Dm/PoHN6+KbFIyd1elB4feCNQHDPmTetWveC1dfgTIJxjj7kTU53F
         dku6sVsEDG11JrvNcfzGiQ4h2zt4cLckwHX1O3i1lK9BhLpUxLO8JoAWcGft+/2JqX6p
         6BLA==
X-Forwarded-Encrypted: i=1; AJvYcCVHgaLn0BsVFjoVOz412w0NWF6W0zhNYOmHt87jX8TWNjr0HezyX0YebB63dp77fTeG5dFvADP8kwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjt1TPLZYGMqpn53L8sh1U6BVg6VfrgBZkXGtDD6/305ExT6wf
	UbR65oFJGNQvieTQNH3j8wYwCzQwaUxowFgV8DULRNps46sxsPGfKQvzEFozvug0944=
X-Gm-Gg: ASbGncu3b0QxNCr3dyoQCAVGnG04bndp1dewBOT3p42RipRjIOsefPlNwZyMkTzKrmA
	ZGmUjiNLR2xoEXadb7w8lHTGPmr/iL2eo+8E6QEfLIU4V1pSOma7ZD1tBQNKfMSABywpoPrbcu2
	yqFSupC0ZM8gNL6IsuLcWOBNIYtu0u7pThtsvooRLq+M+eUSktwsONh3bgpiOLbj5D7XWkt9KRd
	0TMPfopjlTq2jDoHecY/eaI/rjARGRUirRH0MfDZBKyxS5dy69/iHvkQ73uOSHQ9sdfeIAY5Ufi
	afrnK8f+Tigt7g0yWrbwsULlbYTDZgpSxPeEKUke0cNTHVbP1ymOTj05NlDRdRurxfddZktk3v8
	M0aeSqrBI/xo8l6QenSVHmOSLEvCGmE1Li2tRkfXW6/bKH9i2GCuyqnukLb4=
X-Google-Smtp-Source: AGHT+IFi/UqB7Uldrm+9VbwlcvS/K9grf+HFQGwUPWY0Y+SNRhjWVo0c6zi2HNxzYpUPo9jAOLRO3A==
X-Received: by 2002:a17:907:7213:b0:ae0:d798:2ebd with SMTP id a640c23a62f3a-afe295c0e07mr334350266b.35.1755886532255;
        Fri, 22 Aug 2025 11:15:32 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afe49314f63sm16474966b.97.2025.08.22.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:15:31 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: Smita.KoralahalliChannabasappa@amd.com,
	adam.c.preble@intel.com,
	agovindjee@purestorage.com,
	alison.schofield@intel.com,
	ashishk@purestorage.com,
	bamstadt@purestorage.com,
	bhelgaas@google.com,
	bp@alien8.de,
	chao.p.peng@intel.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	ira.weiny@intel.com,
	james.morse@arm.com,
	jrangi@purestorage.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	oohall@gmail.com,
	qingshun.wang@linux.intel.com,
	rafael@kernel.org,
	rhan@purestorage.com,
	rrichter@amd.com,
	sathyanarayanan.kuppuswamy@intel.com,
	sconnor@purestorage.com,
	tony.luck@intel.com,
	vishal.l.verma@intel.com,
	yudong.wang@intel.com,
	zhenzhong.duan@intel.com
Subject: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Date: Fri, 22 Aug 2025 12:15:20 -0600
Message-ID: <20250822181520.12394-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250822165112.GA688464@bhelgaas>
References: <20250822165112.GA688464@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 11:51:12 -0500, Bjorn Helgaas wrote 
> I'm terribly sorry, this is my fault.  It just fell off my list for no
> good reason.  Matthew, if you are able to test and/or provide a
> Reviewed-by, that would be the best thing you can do to move this
> forward (although neither is actually necessary).

It seems for pci there is always a massive list of things in flight..
Difficult for any mortal to keep up with. We pulled the patch into our
kernel & have started testing it. I'll sync-up with my team internally to
see exactly what the plan is & how long we think it will take.

Cheers!
-Matt
