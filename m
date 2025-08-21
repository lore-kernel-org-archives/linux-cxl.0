Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F792E718D
	for <linux-cxl@vger.kernel.org>; Thu, 21 Aug 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795536; cv=none; b=MEDnjs+wAKwK2/AYRTZuVCFY2q3YzznyczrR5qbjYPaQpTF5C/EEXJlB0V1Vv33Q4gKRnv44T1dkbXwJyrid3yvszF2/VgoqeIASE+rca1gTjF4D14keHMIEDXIL1wkp4nuw+2OiHhoRyNGXw91P/BjxMypt8pf/q1LMbZPruDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795536; c=relaxed/simple;
	bh=3A4U0mFlnkILhub4vGFum/rHOWkZrlTYW603OLEkJVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqSq9snyLaZBgrRSMttqwqWYgAIFB0EQ/tOK3psAd0QfUhj93MFZHcGzgYNv5IuKXMZn+IZLKblF+e0qHSh8N9AAXogZ5Kov+Q7V/j7BQJR7k9+ftACk8MyLqIBO24+0S/bs13LI54rKer2gVXX3nufCOIdOzvRqq5hhc/SBD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AKYJcttA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AKYJcttA"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b7532f3so1999909a12.2
        for <linux-cxl@vger.kernel.org>; Thu, 21 Aug 2025 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755795533; x=1756400333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A4U0mFlnkILhub4vGFum/rHOWkZrlTYW603OLEkJVY=;
        b=AKYJcttA/ghZKZYC7tZBkFM0Mb2/EgCjLiCsho3sVE1N0zQlOUuY23ZAdao0V3gQN+
         9bsm8X7d/L0hK6WIDN6Q7JT4qGdMAlNSbC4PrBkk2o//JNflnpbNE6uLpwPORZZJ2WkY
         sZfonTzb7tqKst2ugQrihXHJpDuRGh4bCcGSQ5OvKyLOP0Puz+TmiUU+SESdROqDEE74
         4skQxgs8BJJ/VyO/18R4Hk/Kzc3XXQHtbY6g2AZQmSihSYNMOv6iUPm2j4vWbD29Fh2z
         5bVC0iFxZZYfQAUlio6uwk99op7mmkdITWEJGzXYeLAHqYLk3dY0emEHOQaL3xzXyAXM
         FcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755795533; x=1756400333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A4U0mFlnkILhub4vGFum/rHOWkZrlTYW603OLEkJVY=;
        b=vewlwhfReG0EYvuG6QIZYgGaCW2+4uSggHH5+KFY+Ic06PZBmfTGbyd/+1RCzcBkNT
         Sb77lD7uVqS1iMZNdGKjWwdJzk7HrgJI2pVIvHhOVx5Uvm74Fp/cKynP/EI+wBGOWXq3
         J42ZsHgN2s3Yp2SHrgBicPB2IqS9C77bFOfbKtFvE3p3D/0qZAkOJrZ9++K6IOw0DHWy
         hkE5xchrZacC6DFv23I0mujHKdq5TzdY03CdJK1SB7hT/P6e9rCOzSU/HlBLhYm22OUB
         0SGJR7vf2UOIml2GPoAojq2yAM58cEeQJaLyIxWtBPdIiMp2Jpegs9Ql7Q0S6kzp6fHa
         nC1w==
X-Forwarded-Encrypted: i=1; AJvYcCUzw/b67OPovgQPBLXUeLh9+hkxK4igrOwYJvW+PV2+GbGvpi9xBvcimXBW9FqK2Ra9s5Pc4/Gr890=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmfE14ZofiKap7A2qnk2y++vS3FkcjK3lxqAJg5bpFwrWfz+u8
	PFSHHEaXCIpFAHkcq7unCqSQK2RualjwtwwsrtQLWWRW0pykO3vUmuAE4JZQK61KYzk=
X-Gm-Gg: ASbGncvEquV3HsQTiQquxJbOx+rxpUl+A1JIVyfSEWCzk6vOyv7tV7rQXboa0Z+8fNa
	NvGETXTgSqQECToMCdf6zVa2ZgsH/XlCm0tXA6Ui9oSDRoa3UBSuWbaWyzVvMafh5qA608//E6Q
	AX8k2yRvKHVKP/y9qBkVM4xWOL+X5v93jxn0UnnbBHP+Q3EUR3xlb/jWfLib+UL+wUv2/P0gvjk
	SOGwQYwd6f1j9lOU6F1cf14Y99xmB/lW1FwTJWpPaRC7DvBB8/6jqJxQZZMoFofrHFUmMpSRm5z
	vIZsOZX0UgCK6diTarsqjUCES6YA1ip63e62hQ3Ll1495XZzrnzt6rHRLWVvxUudpQGvcqy3H5c
	fcmICjyN2Q/RV2gP1HO/n0Q4lkESp9cUuefMgW6LTaL+ZAkDL
X-Google-Smtp-Source: AGHT+IHbD3hrlfzfuV9dgz0//kT04PlITNsV9cNrzMXodwD/dQM9X/pgqOr/RoZqgWohk3JzCKOHjg==
X-Received: by 2002:a05:6402:5057:b0:618:6fef:83e9 with SMTP id 4fb4d7f45d1cf-61bf8743d4cmr3099366a12.34.1755795533295;
        Thu, 21 Aug 2025 09:58:53 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61a758ba909sm5450122a12.54.2025.08.21.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:58:51 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: zhenzhong.duan@intel.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
	adam.c.preble@intel.com,
	alison.schofield@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	chao.p.peng@intel.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	helgaas@kernel.org,
	ira.weiny@intel.com,
	james.morse@arm.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	qingshun.wang@linux.intel.com,
	rafael@kernel.org,
	rrichter@amd.com,
	sathyanarayanan.kuppuswamy@intel.com,
	tony.luck@intel.com,
	vishal.l.verma@intel.com,
	yudong.wang@intel.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	ashishk@purestorage.com,
	rhan@purestorage.com,
	jrangi@purestorage.com,
	agovindjee@purestorage.com,
	bamstadt@purestorage.com
Subject: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Date: Thu, 21 Aug 2025 10:58:29 -0600
Message-ID: <20250821165829.3471-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <SJ0PR11MB67441DAC71325558C8881EEF92A62@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <SJ0PR11MB67441DAC71325558C8881EEF92A62@SJ0PR11MB6744.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello. My team had independently started to make a change similar to this
before realizing that someone had already taken a stab at it. It is highly
desirable in my mind to have an improved handling of Advisory Errors in
the upstream kernel. Is there anything we can do to help move this effort
along? Perhaps testing? We have a decent variety of system configurations &
are able to inject various kinds of errors via special devices/commands etc.

Thanks,
-Matt
