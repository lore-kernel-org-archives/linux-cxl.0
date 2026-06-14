Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85222D1931
	for <linux-cxl@vger.kernel.org>; Sun, 14 Jun 2026 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464198; cv=none; b=Sn1pF6wQkwme58SWUeHz5CpITIy/sqhMRlCZNp+mdBVgzGV23NSZHIfaH0ddnvZBu3UhmGTsy7E167itkIYGBzA5jB21utNUlq4B3UrN4rYE7G5zEoh5n00uCUthOLnQQZoBa/5JEZgcLpHxTJaQG5bhwntIczB8IzHuGwmpagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464198; c=relaxed/simple;
	bh=TJZrmbxdEFkLn7jegy74It55QwdIZflKJ1gUU34WXzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KX9EZm1vMDaCT16vX6iBlEZJq7BKqHLxkT0n1zkIcxDFoG8Zjtyb0jfL6C5nNxGVcNOD5OzYtDQaq+2K/GPxn5okEmEBCzKVpo5IkZIlwo0rB+1217iMbdXW6ArEh5hMFA85sWUyJrZBB7g6T+DO3gdFlyLwdVP3YNlnXAROzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JuNqvZbS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuNqvZbS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781464194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bem3v21HI3Dj2XGuqU+Zt2bWvI5Rs5lCN0w9V2Qfknw=;
	b=JuNqvZbSQZkwX6xWhDvJE9zxrvgkUSg7zTPRJa8TGjEIS6qvfdhxohSoFlFi1qNel5XN2A
	RpGlq1oA/gpqtMgr2ZrCZt1LH2QNjCrs2kY4sgx2rgBN5Tak2bcAE68NMwv3yzJEbJQNR6
	EiNFFSZWHkfOpOwjr/mfQDqk1I8Ffuw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-_PXgqnJ2M0akRV1-EUgS2Q-1; Sun, 14 Jun 2026 15:09:53 -0400
X-MC-Unique: _PXgqnJ2M0akRV1-EUgS2Q-1
X-Mimecast-MFC-AGG-ID: _PXgqnJ2M0akRV1-EUgS2Q_1781464192
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso1417758f8f.3
        for <linux-cxl@vger.kernel.org>; Sun, 14 Jun 2026 12:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781464192; x=1782068992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bem3v21HI3Dj2XGuqU+Zt2bWvI5Rs5lCN0w9V2Qfknw=;
        b=BL9MqlZMMnU8yDlI2GvlriB0paY2AQfykrgQSTy7eXX7gSVekyMgpp2RpW0iIMPtUk
         NwKqfft8uir3SaswAwFxC8lJMDDOtVZh7geEODcF435LiQ936hbl6zjMJQAjUM7Ce799
         4vmdGIVeCw4ZuxbWu5owkNjUEWyZ3fJ8PSdpfbMe5rJ0DOdAzfy3BQhwAlPmpHKlmGjQ
         /SrojDzd+0jx3gZ6BegMP9vllYKbKv7qepbaIMrD1FpWwes+lHvjll66H6pUvQsrEOj2
         75LJdsxkE5nuUCni1zE848t446SujmGo3F3I441IOwd8MBUKEtIc4L3aCXwd7zM8S0z5
         4oaw==
X-Forwarded-Encrypted: i=1; AFNElJ+Cecr4VhMifjstOCDWjEm1CVAsJ7a2PIi4oQyyBmFQK6ernfm9kmfyReNX5QSl08H8JYxIUz3O4vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/8V3gCztHmqxaV9uNHVUdRStPbbPNP4vc1SlaK4DoY9ImNIb
	s18dpJD3mvHSoAMbfyhoTs+zX9lgAOsdHGMoFancefvODctA8llsQjFjMgRtyK946Hbbf9B3EE5
	9T+SS9omYPtrCEafjc/kO1sgFeRPAkr3gM8NkJAC7yRTelFYVW+uvF5kTSq422w==
X-Gm-Gg: Acq92OHlhPy7Mwc/GSf0QwNfsrqKAMeN/CeskE5TjgAYYCb2/dKHwo0usbnKZv1s4sa
	SSqt2F439KEVL87/ZEPbE5A9Ss57mhhAlplY05BMG5i6o+JuJHjRsTvwGtqp5tcjVVXtSyB6qIJ
	liZiwJ7Tn3uR/e+M6OhZo2TPC8nzGtyhSANn+PEHblacAXb7wf8x+ZZV0H5Rhsj0R0gx5qL6N76
	eWVB73FDHPv+bOj63Zuyd1P1C41KhZcXwsZf7dLvMPsOGAIfQb9urStYDpJ2XTVxPcicSXL4DlL
	nZo8EQ73irXUFDGWPKNxek83ZedEO2421Ur05IiakJUSGl15dpRt0XE7qQF1QpeEKTdapuFVHah
	73wuZmz8JWYZt4WkO/1VhlxqPRL/IG0LMCxKVoOQBNpo=
X-Received: by 2002:a5d:5f44:0:b0:460:1c5b:f25f with SMTP id ffacd0b85a97d-4606db96c29mr16507312f8f.20.1781464191917;
        Sun, 14 Jun 2026 12:09:51 -0700 (PDT)
X-Received: by 2002:a5d:5f44:0:b0:460:1c5b:f25f with SMTP id ffacd0b85a97d-4606db96c29mr16507276f8f.20.1781464191434;
        Sun, 14 Jun 2026 12:09:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b1056sm27207478f8f.18.2026.06.14.12.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:09:51 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 099/106] hw/cxl: Fix handling of component ID to not assume it
 is a string
Message-ID: <91beb27a4851fe47fe68a5f715af5db456b9d37d.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HyHFpomrii8NSlejovYL2jmo3ofT7OIE3Oy5fL5o0nw_1781464192
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Shiju Jose <shiju.jose@huawei.com>

Add following fixes,
1. Coverity reports a warning (CID 1645325) for use of strncpy() in
handling of component ID. In cxl_create_mem_sparing_event_records(),
fix handling of component ID to not assume it is a string by replacing
strncpy with memcpy to solve this warning and copy the entire component
ID data, which is 16 bytes.

2. In cxl_maintenance_insert(),
 - replace strncpy with memcpy to copy full data because component ID,
   which is 16 bytes data.
 - remove memset which is not required.

Closes ("https://lore.kernel.org/qemu-devel/CAFEAcA_CsVe4TUVm3o_-BA4hXvi2xAThGX5T97amgTQKW_kiYA@mail.gmail.com/")

Fixes: 5e5a86bab830("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260306101423.986-2-shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 4 ++--
 hw/mem/cxl_type3.c         | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e8625..6b16cc206f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1994,8 +1994,8 @@ static void cxl_create_mem_sparing_event_records(CXLType3Dev *ct3d,
         stw_le_p(&event_rec.column, ent->column);
         event_rec.sub_channel = ent->sub_channel;
         if (ent->validity_flags & CXL_MSER_VALID_COMP_ID) {
-            strncpy((char *)event_rec.component_id, (char *)ent->component_id,
-                    sizeof(event_rec.component_id));
+            memcpy(event_rec.component_id, ent->component_id,
+                   sizeof(event_rec.component_id));
         }
     } else if (sparing_pi) {
         event_rec.flags = CXL_MSER_FLAGS_QUERY_RESOURCES;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4739239da3..3cb1096e16 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1767,7 +1767,6 @@ static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa,
         }
     }
     m = g_new0(CXLMaintenance, 1);
-    memset(m, 0, sizeof(*m));
     m->dpa = dpa;
     m->validity_flags = 0;
 
@@ -1804,8 +1803,7 @@ static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa,
         m->validity_flags |= CXL_MSER_VALID_SUB_CHANNEL;
     }
     if (component_id) {
-        strncpy((char *)m->component_id, component_id,
-                sizeof(m->component_id) - 1);
+        memcpy(m->component_id, component_id, sizeof(m->component_id));
         m->validity_flags |= CXL_MSER_VALID_COMP_ID;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             m->validity_flags |= CXL_MSER_VALID_COMP_ID_FORMAT;
-- 
MST

