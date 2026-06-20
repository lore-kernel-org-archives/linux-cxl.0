Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874E15E97
	for <linux-cxl@vger.kernel.org>; Sat, 20 Jun 2026 04:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781930135; cv=none; b=nQxCjPby2Sh8aLjpu+Oq7LBO2znJYtyCmz43vHMCVrkNGnSKSo5wMKAYs/Mr8BEjHulflSRi0DAsa46vfqlBckmOvdy3L1bxKfHbFcu9Z1L/BEYR4hwE2+2ukre1798dgjWNCJsD1/00Fxd6ZB6HG8QEwWBlXU0rbVuCH2yU4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781930135; c=relaxed/simple;
	bh=kSv4MA36IPr6MEzjvwZbLbV45yshsYHzT/WfGQWoJNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mj/KPDYpWPHunxs0gI+zF2KR68g3A/wgQaYj/eGcOeF61SOTqU1EFN/tbBBokmWwtKCpCjhToeLn6i/Zcf5TsXqUPZTV5lVZ6xFcJ3MMVIlyYtBuweIs2rr96k3jjiOsPWgGoJTjKzK9zAjeTfJm4ifKRIezyMOwYfTNjSflcTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUldSjsf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUldSjsf"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423610ec93so2439716b3a.2
        for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 21:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781930134; x=1782534934; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxyJ9MTCZF3WBPRc5KCZ9RrGOBPmsQVAbK6scasQEVk=;
        b=PUldSjsfKD5DzdVkbZ82z9VCjSOhlvxIz53O/nvtZndf4iWuf7F8z8DxkP+Yw7XyXY
         YvF26fQ+tp4iC9fIAaTW+CGn3SRAFypjmTi0C+V+aVnp8LOWnNlSZ8iEfPc1LvDQlbfg
         52IM2afUmI1QpeNoJv7EYZSZgaeWhaOuLSQfZ5slz/ABjypmqWuw/I7xG4rKVVCwNtKu
         viBNnOLuDBa4cpnxfLu0mKxk1QlzRDDBkffhivk/5nAPp8QrMKC10os/qzy7gMK3RpJm
         Gsq5GUu+uHp7AOr6e4DF4ySWTkQ2X5IyboQPkf3Ykzj48oqAYMWcfH6iCmgHb8dL9RPF
         jkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781930134; x=1782534934;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxyJ9MTCZF3WBPRc5KCZ9RrGOBPmsQVAbK6scasQEVk=;
        b=QR458VbbrGe7/I3q2hEn8YANnqYdP+94/TFxOX5o3TleXqPk9NXT+k+XZvzcu9s6p5
         c4eLML4/MQx04552GtjQV5Fa4lgNJZdVf9gZrSO0XBADt9T2AegCNs3wfNWvvDzKPuYZ
         BvlfKHhp74stLV8mVcie7nUbW7heQYDLXysNfw7I5Gy9kgGYLPv+RPKtUMW944ZxyrGE
         8QkphWuoHeNcsCvkVLIHpBcp3OnUHxuoUIw6Z0PTwabmSqn5JXK1zhkJw63pdpSgB827
         8Xyz91GGbwSq+yHh94ZAKUM+FtihLScQdd+l16GrXxTdGi1UoTXMQRXl9BX83cWjF60O
         l6hQ==
X-Gm-Message-State: AOJu0YwB5MnCL+B90uSFGSlprHcinf2R/CiRfISoJ8pbgYCSlhZx19Io
	+3mE+y4bcVfYu12WnHkUWYXhVcyrBntRGvt9psB1Yl6jDt8/OptLfLUC
X-Gm-Gg: AfdE7cmYIqYxerxVCbpi6mddF6+DRHot1SBVDKBnUKIC2DwyjM+e5wLbZI7AqxTuCSD
	oTf0KKOdCD1nQ6u07XQu9nVdQdzYKKUpItwHp5rla1Jn0i1ld2YubwAJUJkDSvhyxF238k6tyr2
	42IGfg9G2xP5zKd7hRnXBx62H4cfFiWBHAEPBfIa3nv8QjA4GD/sad/ajFVqAhGB+EAeAC66RN5
	iO5EKhpCQFWHMlzKnQSvrgBw9DIxMEKSkZroAYFUQ8IC5qu4oqclrd2HQfLl9chW+4LR7UlxTAk
	M1aTgbnOVffqWKUMHB40caA0qZCO9xOgy84qUJJLXVs5wyCl3j0qoe8mT5eth0wgCSxXw6YBO2i
	7Pc6N6zSaY4mvnqwyzI7BrnlrCoi5oVy2erVAfAwL80akwvL9+poSI7fJQKgWTJ36lNP/+JCgEV
	+TLbFSWpJOmQ5z8v6Jp4EWhGh1CXe1rJlos0JbF9e3
X-Received: by 2002:aa7:8882:0:b0:842:7e7f:2914 with SMTP id d2e1a72fcca58-8455078a5a4mr6379696b3a.4.1781930133904;
        Fri, 19 Jun 2026 21:35:33 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([36.21.135.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d8d13dsm828955b3a.23.2026.06.19.21.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 21:35:33 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Sat, 20 Jun 2026 12:33:15 +0800
Subject: [PATCH] cxl/features: bound fwctl command payload to the input
 buffer
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAoYNmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyMD3eSKHN208uSSHN38/CRdS/PElCQjCzOTZNNkJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAFUvUiZxAAAA
X-Change-ID: 20260620-cxl-fwctl-oob-97adb2864c5c
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Yuhao Jiang <danisjiang@gmail.com>, 
 Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781930127; l=2211;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=kSv4MA36IPr6MEzjvwZbLbV45yshsYHzT/WfGQWoJNQ=;
 b=055P543BJbHjOIPyyF7eZanEQvRJ0DxSkbH/jjg7phuKjE7An8XOiKj/BiyW4dJGW/t0yOlL5
 BWOsNO6rpE0CEAxDQN5Fu5Fq5YJdYvzBZMLm8ZthWjMgyK8YczSGaN4
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

fwctl_cmd_rpc() copies cmd->in_len bytes into inbuf = kvzalloc(cmd->in_len)
and passes inbuf and in_len to ->fw_rpc(). The CXL callback cxlctl_fw_rpc()
ignores in_len and never checks the user-controlled op_size against it.

cxlctl_set_feature() bounds op_size only from below
(op_size <= sizeof(feat_in->hdr)) and then reads op_size - sizeof(hdr)
bytes from feat_in->feat_data via cxl_set_feature(). With a small in_len
and a large op_size the first memcpy() already reads past the
kvzalloc(in_len) buffer; the out-of-bounds bytes are placed in the mailbox
payload and sent to the device, and a large enough op_size can walk into
unmapped memory and oops the kernel. The Get paths pin op_size to a fixed
size but likewise read the input struct without checking in_len.

Reject, at the single dispatch point, any request whose fixed header plus
op_size does not fit in the copied-in buffer. The lower-bound test guards
the subtraction and ensures op_size was copied in before it is read.

Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/cxl/core/features.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 3435db9ea6b1..a76142b72935 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -649,7 +649,13 @@ static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 	struct cxl_memdev *cxlmd = fwctl_to_memdev(fwctl_dev);
 	struct cxl_features_state *cxlfs = to_cxlfs(cxlmd->cxlds);
 	const struct fwctl_rpc_cxl *rpc_in = in;
-	u16 opcode = rpc_in->opcode;
+	u16 opcode;
+
+	if (in_len < sizeof(rpc_in->hdr) ||
+	    rpc_in->op_size > in_len - sizeof(rpc_in->hdr))
+		return ERR_PTR(-EINVAL);
+
+	opcode = rpc_in->opcode;
 
 	if (!cxlctl_validate_hw_command(cxlfs, rpc_in, scope, opcode))
 		return ERR_PTR(-EINVAL);

---
base-commit: a48671671df5158a0b8e564cd509e04a090a941b
change-id: 20260620-cxl-fwctl-oob-97adb2864c5c

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

