Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880B239E91
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193349; cv=none; b=YFCoElzJwqj4h30G2UKs/6IpfMzurpIwDptJ3/tGoNalBVfWSf/Up2ItvA/pt99kPhqT+2qsLysODdao1omKhKyxS3bdpT0dYPQuYeyMbtXCR3Ue5fIagA11xsHVk83KtXOKrsuDTmFabT1UTEaFbNOCxmdkDVpHKuh4E9uSin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193349; c=relaxed/simple;
	bh=YEdOoO9/PsTYwjEuUfGww3T+6XYUej0fn/S2ktQUcfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cq2C9gQZftkcgd/p7m2N2XnOwJ4jqAEE2co9+ja9qqkDCwhBL2wiYcqxq703a6BQJpbGbDHTSE/rnA48qBgDuOuU4iCCJWPhdc4MHiqdrNngc7pbhDv9F/2s5ShvFYQm+4gcwbSZhNmLq2rNSJUHHCzCl9GusZhDq7uAMKqLcnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIgZsgGA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIgZsgGA"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e77831d68so50791227b3.2
        for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753193347; x=1753798147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVz/SWQP7VE6zR7u8S3n9pcQtSS3ypPiadReAwwwScg=;
        b=IIgZsgGAljr2g8YwSSSevckK6iBQP+RONfO0crGnfIZ8/IkO/P613sSyBUhD8xBour
         eq3Q1KB4clXdMogVSxrFDPhBiR5WBOSZh8pfa+HZpQj/Qky+lJLGBRk3PBXNF9wztbO5
         C3l6/rPrwDX0wynMwApJQGXLfBjxVM2KxmPCtqhm8a7Ra1E7QAq+QSwkEOrtfnm769IS
         a+khXFjKhC4E1JLi0cFJuvD3wY/tXGY9WbvYQuvsBehn2V553WM1p0py8+iP/6VV+73n
         q2W8sp9whb88kwxZhDA5gSgmvshlU0dHA7dDxmC2IpweRklXKaIzJ93WPTSqt9ibd799
         MDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193347; x=1753798147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVz/SWQP7VE6zR7u8S3n9pcQtSS3ypPiadReAwwwScg=;
        b=bd8LZn/VM9XUeuvzl7CZFkKNqlJu6rp+oZD0Er5+Di25rlBZgIzOZguYvcwVRUL7P6
         GiZKAsGfug7Iw0fB4HjfolHkO7X/7GDTynOsbw7VnEG7h8Do5B5dwTnSkG5k+D6R+FiL
         CSUskuSETTNK39O1tzkS5HwU3JAZKM5ehMYy7JfxcMwX1gg88mDbN3GXRilLkQ5Mumgl
         J4N2zFeC5aoFmbcXp4/Ec8+X77vq+77FAGns74qEITo/2RtgnekmrF+iuVMLtG9WLO4r
         hAgfuyuL/dTVJnPsVjb22IxRgDvuNUK3gRFar9HTvUV4UjJLlAZA4NwMxw4nGn8UErmD
         SyaA==
X-Gm-Message-State: AOJu0YzB64YXo/BH5y9LO5rzwffYbIwqKekNWlFtwoc0x8uH7kHOW3yJ
	QNgvz9nG2kmuBC8FYODCCDFqeVSnWSQX5z/tUZfAoNPTUZ4XbwxPw4LlJfUf6g==
X-Gm-Gg: ASbGncst5vXXShXnVU/0cmcQCU2ZsvJjsPrtdWBLgtZgvLpsStxLJQylu88q8KNQxQQ
	vbOhLNTomLHBLOKh3B9N6CEtxxVcqZUL5dR5jBDt08xwLXqmk1a3XUTOoGmF2M4PipzAXgcXgRu
	xM37X1iKRR8nzRoTzQ2ZrmG7yR34WSGZzJ0LGWAdMkzF29YwLTS0uSYXNjrY9wekMQxzCmUdV1L
	7bKgPrV/HwW6BcDswuszr9+PlaASvVnmubiwu5Pm13MWgtRV/2UZMNhO2uZaOGalHfTW+SiLXOL
	XZSdmhwENBCKZBE+0+te3ch8LO3dss6+irG1aDtev2M8u/H516C2wSsxBt8K5UHae7kS5Uh8HeH
	R1T2B1EaEbYvAofahmMuJGA==
X-Google-Smtp-Source: AGHT+IE6Z5u4fJKSms1PDQMBY8W3jr0HoPdpNFmj6FszKY3nIu7XcOeTv1JtQpxweYdNc9PM1kYW1g==
X-Received: by 2002:a05:690c:f8b:b0:719:671d:255 with SMTP id 00721157ae682-719671d039cmr163597087b3.3.1753193347188;
        Tue, 22 Jul 2025 07:09:07 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71953140caasm23954697b3.37.2025.07.22.07.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:09:06 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
Date: Tue, 22 Jul 2025 07:08:59 -0700
Message-ID: <20250722140905.178926-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250721170415.285961-1-dave.jiang@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 10:04:15 -0700 Dave Jiang <dave.jiang@intel.com> wrote:

> Remove from core/pci_aer.c and move the CONFIG_PCIEAER_CXL ifdef to
> cxlpci.h to deal with the exported symbols as needed. There is enough
> AER handling code (and more to come) to move the AER code to its own
> C file.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Address 0-day reprot of cxl_handle_rdport_errors symbol undefined
> ---

Hello Dave, thank you for the patch! This makes a lot of sense to me and
it all looks good : -)

Feel free to add a
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Have a great day!
Joshua
