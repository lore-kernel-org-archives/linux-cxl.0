Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8C3E1CF8
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858688; cv=none; b=RHo+U/PiGpLzu+DYJIr64rZwvPiEy85TOKGyTif0aIM7JuzUhGTGtTPkebBimWk8579sz5MN60Bq2kRspS6iZpXzoJhBHCPZU/ToYVkyFP6Naxzwn2A3yDy5a5JW7Uj4/K31/kerCzVWgaM3glFZ2roicEWX19tmtGjsGg9DB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858688; c=relaxed/simple;
	bh=v5tONA2LxrOLSUjqd88pbtiKH2gaZjORspEuhh6aOns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oyIteaUimHNC+jkChFWmNlgRpZjWyRAtZttElgjHbtwFf+MTHz730veSV47LMqUvYRhgaBTLnqmwHzI8n4PL/mMm2f+zcpJXOhTT+Onp0ub1TedA4wpX/iRy+hiyN7g7+s8fDSGG7nv/Op9/JbzQHgVNI16FRKXytMN17iAUe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBwdtiT9; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBwdtiT9"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3ab86ae9b80so984111a91.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 19:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791858686; x=1792463486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v5tONA2LxrOLSUjqd88pbtiKH2gaZjORspEuhh6aOns=;
        b=WBwdtiT9bnfcR6oU5J9hvGPPsl1VYrtXNfTCfAnjawEHtvD6WikdXXUwNf27v8mMYq
         i+JF+IDNSKB/6NS/3miLYWZKANDFun1Lvph7k8JKtXrnCCxfTbA9iDUxDOsaB4B8npH9
         vOR4aYP6p/3DC1/OA0XL/D7QFZjujS70Vf9BM6UoOHLzzLEU6HEMF5yhb1CEJj8ltUMC
         yoeGE0497bUXj5PzMlrxX/nj+A5ogAgIgEQlrW3ZWVimJ/gBpAqWc44JB43f+jwKOBzN
         3n10I/tA1Ib2UMbjdZyPb3eeq9fDYHBoxzS5rBgDWWvcg9S7aL54E9E90Osr5utrej75
         G4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791858686; x=1792463486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5tONA2LxrOLSUjqd88pbtiKH2gaZjORspEuhh6aOns=;
        b=T6fXWOTYdNBtpz2CZK0kSie9yVpQcgeWyE5KfCLf1XlhG3v7vnv+JJz6130lcHco9N
         YtUI2w62jOHluoAi7s8tGsqK4AJDeQk8tqB2V5yPuW2N37AM9+Ojkg0LkIt23xQvlRkk
         1LEKQewd93oMVRX1izPuY0t8aeufTbNOEXgPkAyqYi8X2FF4goYhU4e1uWYuqgGJpL/D
         h9IQaKpA0vLBNu1/s1JOUW2m8fK+AT6MZN3WZE7lXmQy0aomUpzKaSdbscWqpc0kYBNv
         gUpgdFa77y7UL5jzAL46qCsPbxIfjd7vwYbt4FVB/V3qwr/uzcHL52cI3sA4txoeMIep
         R7/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwpmzD9rsoS7nYEnQXNbsT5F0QxY8O8qjKQP4TamfKsDBWwy+mX8Ud+0K6TplOgIGw/Zh7bngOX+sk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJz2OrDUZ96hJIRbwuC72fH7Jq9809ZiLTpV8mTsxxh6Vg74N8U
	PLwfVRIzvE9hdIyCBgXxcISBi4+cAbGV9y4I0R3y2P7NY0hvmiWerqf2
X-Gm-Gg: AYBFou1uJTRmSObw+NzH092IcMI2sK8KkxD6PFGSuyQ6q8MEH1bWX6isMbrRCk+JwMw
	qACM247efpYy3+GWeDLvLd5draA8tE1O9tAaTr2iniciNqke+f/Wpleeg4ZcnZE0dfs1pHu3zHh
	ApwqfwN6BG9dEF+pdLhk8xES6CPQeFRbAvJl3CNs49rEjAnKoibzbjg0qp2ekJNqOL1/D3qcSih
	89IMNFXgPFdtTOYl2n9/kyU8aKSZ0uWDj0beThsQr9uCHcfizjMFFDPqwwAxWmq3aq9v9gwuB8v
	GyHwqTMdBvbMiDHdCZDMLMKvk15oY2Jw2GHFjBZCYdt1qrEzBTp2Z8QuvmdWD30n54VGl4IfSE5
	137WzsAvCPhY4ioknzLH5mUfKMe/r0m9zjOCYpdMOkpsgE7yIziBU4zuMVFGPFKGgAPZdCZ8BZF
	4rj6+um7DuuTCiWrppehKMSSR23Sh/q+KcOEdK3kg+6mxk8rjzJTWa2ZGeAdNgrWK72uy/rH98y
	B8IpJ0WVZ6vWemC1foJJFkIWbI1BnERjIk4Z8oV2FAStzhSfevTTyBRa7vS09d5v0n1uuJMiEvh
	WLLdTT+Ob7UVuBhTlvd0QQbyq1z0TrjaaULOcaNc
X-Received: by 2002:a05:6a00:8019:b0:886:84c7:72b3 with SMTP id d2e1a72fcca58-897c78d79d0mr9188887b3a.26.1791858686286;
        Mon, 12 Oct 2026 19:31:26 -0700 (PDT)
Received: from localhost (ec2-13-231-150-91.ap-northeast-1.compute.amazonaws.com. [13.231.150.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c310738dsm4513065b3a.16.2026.10.12.19.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:31:25 -0700 (PDT)
From: jianyungao89@gmail.com
To: songmuchun@bytedance.com
Cc: akpm@linux-foundation.org,
	alison.schofield@intel.com,
	dave.jiang@intel.com,
	djbw@kernel.org,
	joao.m.martins@oracle.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	nvdimm@lists.linux.dev,
	vishal.l.verma@intel.com,
	Jianyun Gao <jianyungao89@gmail.com>
Subject: Re: [PATCH v3 1/2] dax/bus: fix mapping attribute error reporting
Date: Tue, 13 Oct 2026 10:31:21 +0800
Message-Id: <20261013023121.11036-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924025035.1265035-2-songmuchun@bytedance.com>
References: <20260924025035.1265035-2-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

This patch also fixes the mapping_store() error return issue I reported.
The fix looks correct to me.

Reviewed-by: Jianyun Gao <jianyungao89@gmail.com>
