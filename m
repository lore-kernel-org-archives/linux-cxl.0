Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182142056;
	Sun, 17 Aug 2025 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755453116; cv=none; b=GKfIsKusfe/fNQAHHdJl8l4leLz6fpSq7c8pAFbi29cwtxpPVad1Z5clwNEuW8Zo3qxKarFA1sht+GL5jliQaxtyZxYEYQUfqo2H9ZpXm5bmtYgRUz5AkLS84+4Wfq03YCCshwhk1TcF1R4Vue1FiwcJeLWhniipWgzhpmI9c8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755453116; c=relaxed/simple;
	bh=cURaJ+5cVQSqJU9KslDGDbYDBdJAmFLl/jJs6cOvljU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0l0mAgJstgAoHl5tM8X16qt0eXI2PEpHx/uNk7XMdJaRVgMcoRbXPir8VJq4ECfEtLGZN/fToqaXf4OslYK4hBp39qN4fNUGteoVBqVqe0bumRP50Z8+IrNukeEiLYrpsz/BLn4RhFi+AibVJ87nqv2mJlgwG2muGOObKGjYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghcplkpn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghcplkpn"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2430c5b1b32so27013205ad.1;
        Sun, 17 Aug 2025 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755453114; x=1756057914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3QG507El1mmJsiZaCHgTNCBhi5aSvoL795gwkq7Ka5E=;
        b=GhcplkpnH8UJyeVC2nzLOeI8tVpU6gRllfbsRVhCakyG1gsN7Y52Qa2ctDTtWvcPTd
         eKmzcBp6HRGzOQ8Bo6b3YsjhI/svbyMKN68V6/97n5WDjIPpAOYcg4ORWvTSLQS0gFcY
         XwGwrFEvhvDcUmgWYg2iawInK/XgWzljQeSkTTbqFp5bFuKCtbaVmrktU0Jr4ey3s4Dt
         L+TLfL6YkcVdoy0OMhBN9xk9vo4+GRivAIxWfYkpvK30l162FK5U158wF89F7ow331NY
         HHf4T1v/fxr05fSg38U3VsInAzrznHlZwvFhhKFZDBi4jSu8BjJhDH9X34z3b7oaQB4H
         ZZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755453114; x=1756057914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QG507El1mmJsiZaCHgTNCBhi5aSvoL795gwkq7Ka5E=;
        b=uO2HQcK7Ri5cXRhJzKrdAWitXntXhlxmmLx/Cwb3gG2RKOVjvzcvsZH2+LZinmSsaV
         8tcb1z3Fe9lGVEHTAaO6ZmdftYlcYXxtCXbTJ3+x+D2u8YB/FCo9WBIsAq//DnULZawz
         YcC/mKRVDQcLmyE79salmz9wWF7s/hSZfaEufXZCWXTn65XIWFqVGSlimpjVtGbNNcq0
         qSlbrEWcvHdw8dcqXUWeHzf+Qze0NLSlXMXCQ58ez+//EYf5RtJnCkFApbvL7DYjeBhz
         aWGcDbMrH3OM2Rwj5dO+gRwnaZpK5O8N8pngsgEGWb3NYdr0m5xfatDrCqKwL6YUH6jP
         LAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq0JqGDZyLGla4DDNb1Og7FhA9w9/TnhJAu4UTvxYwbAM1BjF8+MuFBfm0J7YWV7jFeTLkJOLNzD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0Krxr8hMW6pzFSMnWKNmFZ1Pqr1EwNru5QPfDUC8A5+fkZW2
	xgE2tPiSMTaCXz18sxGGozRxJG/srg/gmZsq44BSNCGTnI2y5MC1Bq7qwWwaJXBqnIc=
X-Gm-Gg: ASbGncumqKqWo3Ls/BVViL1TF2mKCJ+rtbzbLigb9BmoWvWG6UBzWy3vjCtiLgDNH+5
	kw8DTZTuat4BRprMfUILMHyhCze6R/7iChsnSiG6LLRlcpiqIx8+xZtko24V8K7M7rA8mKEWjB8
	RrbjB9eIG5TcnyZjyu4RbY0kggmb+JwB4Tmd1E+4BhaVJ6JSYlxtqtuk3C04BjHxBScyg6TPOLx
	ATstNXij/zJur/soVLh2jQwroR2UibYmyIt7UXw3wipH/C0EtTfRzBcyRp6/imCa9cj7TKFftrG
	5kn4x5cE9qyd8HWrv2Ptio27k+HmgEFAuxjLC07IOZF1KUga8j+E6UfAkWjk6NfRoMBTmSw10LV
	NI0bHWZ5bWNVpBKR3yyQ0HMMoWu3VKQ==
X-Google-Smtp-Source: AGHT+IGWskQPRNPAgR8Rze5fL7J5s4uZcyQT3GWuhl8vgwShbcJQ7Fou5ZqjMHZQ9ifBAuMxmQVxYw==
X-Received: by 2002:a17:902:e88b:b0:240:5c75:4d48 with SMTP id d9443c01a7336-2446bdfd789mr134078535ad.25.1755453114191;
        Sun, 17 Aug 2025 10:51:54 -0700 (PDT)
Received: from lkmp.. ([157.51.82.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0635csm58931965ad.53.2025.08.17.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:51:53 -0700 (PDT)
From: rakuram <rakuram.e96@gmail.com>
To: linux-doc@vger.kernel.org
Cc: dan.j.williams@intel.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	jonathan.cameron@huawei.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	linux-cxl@vger.kernel.org,
	alison.schofield@intel.com,
	gourry@gourry.net,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	corbet@lwn.net,
	rakuram.e96@gmail.com
Subject: [PATCH v2] Documentation/driver-api: Fix typo error in cxl
Date: Sun, 17 Aug 2025 23:03:56 +0530
Message-ID: <20250817173355.6615-2-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the following typo errors

intersparsed ==> interspersed
in Documentation/driver-api/cxl/platform/bios-and-efi.rst

---
Changelog:

Changes since v1:
Dropped fix for page-allocator.rst as requested by Gregory

Suggested-by: Gregory Price <gourry@gourry.net> 
Signed-off-by: rakuram <rakuram.e96@gmail.com>
---
 Documentation/driver-api/cxl/platform/bios-and-efi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
index 645322632cc9..a9aa0ccd92af 100644
--- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
+++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
@@ -202,7 +202,7 @@ future and such a configuration should be avoided.
 
 Memory Holes
 ------------
-If your platform includes memory holes intersparsed between your CXL memory, it
+If your platform includes memory holes interspersed between your CXL memory, it
 is recommended to utilize multiple decoders to cover these regions of memory,
 rather than try to program the decoders to accept the entire range and expect
 Linux to manage the overlap.
-- 
2.43.0

