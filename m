Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5C1FE44D;
	Sun, 17 Aug 2025 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755453049; cv=none; b=alIkYkO9Wqe2j5fxfhhFSIWs/7XlotQkzt9QHhCe6VJgsgy9CUsOvmInbjbyykVPjpNufC+bhywdV9Mat/goON+xySH/nJMbzPpGw1rs6/psmCkZOo9ocYT6hhbq7p85F7LN0PQyBN4eX3hLC6fZDve5teUw4+Rn/apaC7DJgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755453049; c=relaxed/simple;
	bh=kxPQgkJiRwpdamMhQNsqSB3KW+32Rbalfx4xy59hTTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjpIkODqo5ucDfhUVBYq/UvFYlzx2vW22DVKTSUfb47cnNayarWwtxV+oWcxKLT1/ick0gprERIr6xVRP2X7O2KoH3JswkmLTZ441N7Jh1rfNS6jAGgO/5/TYUcBtNVVJ+9UlGPHXfbm+QX5EURNJ8EfbKkIJpYeX60Q4rTV/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRFgyqPi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRFgyqPi"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323266b2368so2184898a91.0;
        Sun, 17 Aug 2025 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755453047; x=1756057847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWZaVseHO/HpQONflG4VKxSa+b3LTJhK7Ltl+j+pOUg=;
        b=LRFgyqPij+rQARj8moQjXOQeEH/0eA2Npv0zlBi3/4Qg6xow6esfYautBdGWkWiShj
         YRRIdki6rDWDE9pSF70lZ+iLvx8uxN1Szg8PBugcyr0iyNU4dRU0S/Xns9cR55RFK4Wf
         xuLYo0P1YTlz3sVvkPVBt5vaClPB04wPzwsHb6ajD5VtXPim1YNLNvL4ypj/sHZf7hOA
         zAi1J5rKQZNTtHiD1UfyX6AqELSG/Yn/iD9aHFYb1/o5ovTy7jp0tS4u4+oYlv2p+VsN
         jo7dwffMicfFOVzNSg90xZ81ScSfL0sFQEB6rB2g1rV/TyDBWnK3D2Q8DyR8v/GGZ3CM
         VIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755453047; x=1756057847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWZaVseHO/HpQONflG4VKxSa+b3LTJhK7Ltl+j+pOUg=;
        b=ai/U9FIotgOz4h1gn1WrJy6gKBqC7tNIGwNCg6IKgg8pZTaNlR6m9hFc/IGJm6kAfz
         yFWNno+qBg4Wf0lNnfLi+eEHvd16Tz3ZNISWKhiRDn1+dotSZU25recUKqEqmCcEr2Oy
         UdN2Snh/G0jAx2bzF8gobgAoai8rsCkNGW7tw+DJveX3I1/D5ygIp7xZxFUvaMx3IaVA
         M1tkEVFMpC1MsST3y0vsqeZhf5OuC+8NMQeek1T4oWQu+ArnMMxQ33FmIfPt/WcyEtwR
         qMVr8AjuNDULKbNa+tStTA8RnBkeOb/YkNRMQrqvFn2DVg5ZrnY/4eJrvxz+R2lSKoq3
         D9xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGGZQ8DnF3BY6d+x6L5y5jhOgC5TIOWNBWu0DJrRx24kVRq8WQxjLtuiF9xGvl6u4yNRKZ4PjvhNA=@vger.kernel.org, AJvYcCXfjZQqoKB1tr33XFw/JG9JR4fxNpaxzlNvmYt9G1fTKVHDXHXOUz4pIzUw1AV4+bCJ/Cjh7/1rwd/U@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkx4nMwFy/qc3dUDFsESRcAFNLVQC1aUYY+9z76SgVXUiUBE95
	ixeqD25hV1myUqzq5cVaEuXkHPxgUSpA6Uq6JXKARrhSrAmQlO0/i9IW
X-Gm-Gg: ASbGncvSlFEgYGXaMBBcENALu6HM9ice+NG2MvqVHjsSqXy5anj04eZO2rzjWSRzgQz
	vOlxicVg7M1p//Azw8TOPePdras4a3yGQhsBJR/+N5UD7soN+BJ/kOuFZiuXsl+d6JuSDpxVeoz
	njRB8lgArdCrarN9YG97zZJ55SuRlZItwk8pT7hxavNhNJbf6kGq6Dwf5o6nzf/6f4KVGra6BoU
	2cIGc0FBH1INy9X/B8i4DXWFWsru99Wb8qLq3jFOOoCp+5UfVzECMSib2E6YvQ270Y9w2smPpZu
	xShu0f1NnOiIlFn7cmbch3Q3sRG6JNw+H0rW4LpylxRxgDFXMV4xTOpgdulQC68QFmT8mWNRb9r
	qdaMraUUA+CAiVMtnxxO3A9agk8kmEL0tO4AkTXK0
X-Google-Smtp-Source: AGHT+IGZ24e0gHA+JVsQY6YX2jt/f72OrzDBs2UDcSTBqyD5prVbXpazBufiCCm5Zs5j+Xpo9qIt6Q==
X-Received: by 2002:a17:90b:3c42:b0:312:e76f:5213 with SMTP id 98e67ed59e1d1-3234215b3eamr13428682a91.28.1755453046625;
        Sun, 17 Aug 2025 10:50:46 -0700 (PDT)
Received: from lkmp.. ([157.51.85.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d799c8csm6243856a12.55.2025.08.17.10.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:50:45 -0700 (PDT)
From: rakuram <rakuram.e96@gmail.com>
To: gourry@gourry.net
Cc: alison.schofield@intel.com,
	corbet@lwn.net,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com,
	jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	rakuram.e96@gmail.com,
	skhan@linuxfoundation.org,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] Documentation/driver-api: Fix typo error in cxl
Date: Sun, 17 Aug 2025 23:20:35 +0530
Message-ID: <20250817175036.6906-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aKILiuYaijqAZvPR@fedora>
References: <aKILiuYaijqAZvPR@fedora>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ok, Gregory. 

I will send v2 without page-allocator changes as suggested. 
