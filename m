Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD8137C2A
	for <linux-cxl@vger.kernel.org>; Thu, 28 Aug 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342836; cv=none; b=t4TdQxoRVDa0n12+Z2paOFTFtF2SAqXs12c4cTEBHV276ZoY+SJBqXXTxTYa7YsJm/QLQ8c3dA4r8joKYGCZl7MGIrXFA6lBssJlEwnplfZS5SHw7+Gific+NmZX8To5Y734v91+lYAnbwuzM4Q15XbbEx8PnnP7Qv+H7ceE3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342836; c=relaxed/simple;
	bh=KHnu9hnbjEiqlT7kqClbNDC1ZJkTRA3DpS0ShEeR3pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnHl17ZW1cwbaC5EKFq1hADjpzlld3uJWLV4J1l8sABKbqyI2Y4onC9Op4G+SUu0kD17ZP65ulvmMpPAVkCnAUhzs0ZzqXNw96LfXdRzfursAoLI5+/hPJbM4YvGogkS84PWGY6OsT0LVJOAN5NGI9pKSH2x/+D7lNnyfp2oVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bDXguO39; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bDXguO39"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61c51f57224so603237a12.2
        for <linux-cxl@vger.kernel.org>; Wed, 27 Aug 2025 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756342833; x=1756947633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkZV2r2s3Ve2mSW+cNV6K6LiCKiSQdIZC2Q3aoo2TPc=;
        b=bDXguO39kwmE8d8UBDfFCMQgXhLpMoPLw558wv5P1qcuv0Ye2AxgoPOpK81tqrf12J
         BwgfmIyjLhhQyRJvDsLARFcsEpaQiW6CuTGVZSUWJZJr4nMRT+GNWXFyPseRpSFgmp5k
         7C66SlxPjSSAr8eLwsopV+rlmLiDWRi2LjrwoVd7Hh369svazChS4eQVIjX0oT08lmr2
         +wlGd5ShDgtOSRaHj6qK/qo0wQS2jf0xbOrI+mT5l1cYLUbnMn8RlLC1sKjJ06k0WcvG
         CPZtR2WxqWBwnqdFg8BlYBDXWYdZqYDTLdDf4lx0QdpdHwwzSvh4fWIxaYucA1//G+Pc
         0VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756342833; x=1756947633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkZV2r2s3Ve2mSW+cNV6K6LiCKiSQdIZC2Q3aoo2TPc=;
        b=ft/iXLuhAvdUrrDPEi0atkmIff38VRWVRbs1oUBgJYcFe+iG/dPYm2E7QvPnxURWHY
         ncXFzSA1H95zHx65vGLOeRZRimsHeL57CnoZtrKSl0JXKrLqnUISUz1AYQaG6NAgjMdv
         Hub/Jt7zGFn9j3VE4d0A8gQzx+svYRYApOp9ylS3v2wAd5boFxBVPaNpkwL+PzTfJQ3j
         5PT/zRTvGd+8hBn27FlB9F+zOoAH4o/CiSkeDRniLlxkRbhN8RovhsJtFa4N6Bv7JWym
         gAhQOzrGJoicp/9tEffqAX8yhGJQls6XTbS2oDJ6LZ++HDGtQWIUpO5fH7sL8Xbp2xc+
         77OA==
X-Forwarded-Encrypted: i=1; AJvYcCU9s9d8iICajJldO4lTqUzmMr+gqiYMcxUrKLL4z4dU2Q0FG9x3/QB9irLGKnkzYQTMy9RqIw6dECY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNy5iFBkrurqvx3CLh2W1nQlXbtw956QEFKWUqBe27hDMkHgf3
	0kCZ1gmrPuRfwM1207H5V/gVgMgIlmOTEHxSzXoA+ThUVucCUmPvcYPtwNz7eo+O+GU=
X-Gm-Gg: ASbGncsMmMes1qy4r8uKuAW5d1S9r5V8MC6bxbvkNhI1F1alMpCAOLKzvPORiwhKA2s
	O6yHlW9N/g1M49zW9MEDUSsoaUu326NXoGTSR1i+QAodovyhiBMx4gAZUMd7D8V78nw76142i/r
	OnJMS8jZha/jn3GTcwS3GWl+dFfAl0+YRvySgp/6gI3SOKjPCyWa0C2MMKG1qF8Pw4iuXttomli
	C7scqi+oEiZD1t8NRKMonk4Uratkqd433W4uKtMUf+aom1Hr/MjcUfC3DLOYdqxqK66zwaa98BE
	CgiygE4ZIhoGF0O1PrPZvNLnVp6C6YMra241zUmNrzcq0qG40zc8YTnlgYCg2j2Kq5jGADdLj00
	lK0/mm2UPld+G/pu0LC2X3pqwAGxrvIfD6HRThw/Cyzd32qZei9D2NjrqviZwiRA=
X-Google-Smtp-Source: AGHT+IFowfbzDXzfKj1tbin1CbADg6SQUppIoHgdL2LBKWx0TCuFZuLUREbfAZ6iz35NlZp/Mlr9+A==
X-Received: by 2002:a05:6402:a0c1:b0:61c:30cf:885c with SMTP id 4fb4d7f45d1cf-61c30cf8ca9mr15283114a12.32.1756342833263;
        Wed, 27 Aug 2025 18:00:33 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61caeb5e786sm2651785a12.32.2025.08.27.18.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 18:00:32 -0700 (PDT)
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
Date: Wed, 27 Aug 2025 19:00:16 -0600
Message-ID: <20250828010016.5824-1-mattc@purestorage.com>
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
> Matthew, if you are able to test and/or provide a Reviewed-by, that would
> be the best thing you can do to move this forward ...

I spent some time looking at the patch thinking about it a little
more carefully. The only thing I don't really like in this revision
of the patch is the logging for "may cause Advisory". Example below
from "[PATCH v5 2/2] PCI/AER: Print UNCOR_STATUS bits that might be ANFE".

AER: Correctable error message received from 0000:b7:02.0
PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
  device [8086:0db0] error status/mask=00002000/00000000
   [13] NonFatalErr
  Uncorrectable errors that may cause Advisory Non-Fatal:
   [12] TLP

I don't think we really need to log the UE caused by ANF any differently
than any other UE & in fact I would prefer not to. In my mind we should log all
the UE status bits via the same format as before. Taking from example above,
in my mind it would be nice if the logging looked like this.

AER: Correctable error message received from 0000:b7:02.0
PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
  device [8086:0db0] error status/mask=00002000/00000000
   [13] NonFatalErr
PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer
   [12] TLP

If there was only one error (that triggered ANF handling) then we would
know that the Non-Fatal UE was what triggered the NonFatalErr. If some other
Non-Fatal errors are happening at the same time then it doesn't really matter
which was sent via ERR_COR vs ERR_NONFATAL since we would also know from Root
Error Status that we had received at least one of each message type. The
objective in my mind being to free up header-logs & log status details without
making error the recovery worse.

Does this sound reasonable or unreasonable? I can update the patch-set &
re-submit if 'reasonable'.

Cheers!
-Matt
