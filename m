Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADA41A4E7
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186983; cv=none; b=LoFUDwSbojmRue250AnFkMOPkOJBvDdI1wXU8KDfhdNSuu4ZYF7jWrBHTv2BJr9C+9pI3bftmwtQncY8dpqEDxn50lP0iznXyfB830CXomGodI4iYlnoPGcQObLPuFpCe/ihIBzopPcaj7u9iSYFXLImn8HRrLdmCrowd41iPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186983; c=relaxed/simple;
	bh=t6W9N4Lt0S2yTO+Q/M+vHFn7ofP89M+UAmimJ2ozFqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4SKvZ7phJhaOHV/xCer4WVm4VoEb/ImQysBuERvotvfg4nT6HVu9oIKU7NS2jVQRDSh+7qL69in4I+NwwV/y+33FJvbnGuosvitQhWduCguyIBGJGSX5FVdZTjzekS9RVG37LmwKpgsRmdEQBo7OJ1XuUVJPgjPSaR05tMQdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VXKaIQAW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VXKaIQAW"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92ed3993c1eso28242485a.1
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 14:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792186979; x=1792791779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPJTxCtLmLHFQa9V0XSMmI8R2UPplg407V8GNJE/Vao=;
        b=VXKaIQAWIRa+8638sJfT0gGlCqoOfQugKbzi23G413qgF3+lRNAgW6hKV/Je48olum
         FS2k3vF0orUHV79ZU2SOKGOBPgklRJc2ih3hp7o3ujvBRbCQlT6lvh9Sl2FlZHRp+vK/
         KZJZr4gYyHvTlos/4DCZikG74ykqBcPXJz4uZY8ibBE5WM1P2MTaWSIt+jbA7WnYY6JN
         vg71Vb1L06byV29ITBN+1bsrewmWynUFymEkTKyK1wHHScj+oidMSO7LFgGwFinHkton
         AaKazGnCPHj0/DcVcJi3aiUGzxWLFBJcoNy/IjcMSLCKzzjFOdHnf8JdjXUg8rsw56T0
         +Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186979; x=1792791779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPJTxCtLmLHFQa9V0XSMmI8R2UPplg407V8GNJE/Vao=;
        b=S7YmSLoDVxvQfm5JmG1clPtQpSx8zECHadwKvWu6gv04ibM1+nrINslbmUVWvJ9ACR
         /sdZwWSuRYR3XpBjguglfSMQc4PdwnuIQ9uypjCbX/32aGJCsglLsfW2Vfypd30/6U09
         31O0J7Txp27jvT6QwEsKi/ayFQ0oRY09aMnDDVehY4Uemd9k4UWq6GYuBzvWw8LjPsPB
         L2qeLeaTvRpWHuNU46Tm46gYj5TJI/mcARq+nCcTKB4fKOsgNMPNH7gV+r+QRJD70m6C
         vGHE1dTofbIB+fw8PgpgrHLQGcvqvrS/Gg4Q1oHT8L21iPZ+ZvWt0xxWVE/D0b2FtO/X
         jkew==
X-Forwarded-Encrypted: i=1; AKwUvBwzSqwSq3bt6Xy/Ja2xpHhL286wslE5RHMwEOiiiPKpku18CbkIBFV7F/VDE/UqXAuPtQLOMfXRKYg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdlN9zGefCUbnGTfSzPuXn6LSAjNjqD7h0/BAef2+wiPHvBlfL
	hTG6oMGdfLowCsZ9HEoOY9bJ+jMlvSBFQb2yY1wWVRi98EtqvMntUNILG9yuQxKCnQgzMO89dZl
	10P5YVUI=
X-Gm-Gg: AYBFou0G/TFMCbJQIR67HLBtWBfezoRKR1D0rtdRRhB3QT0S4rzrtDCN3gGH51cSh4+
	18wQuvWzMCSm1fsLXtGaJpN6WTpBXp8jpg2KBsrW1TGWwB7Zkdw+cwAMhv3fKW2KmF58TmXsY7s
	WhSxiW/sK3W23+x88J0LleZkDNc6e3/xXBLhHoqb+WB8feNJvy2+zFmId33Xd12WZ0tzq24Jl97
	J18clznvH7QK38LPuvmwzzsK5j6vPNnj1LfIW0BQZlLARMf7Ezj9w2h87wS8GwCGIO/HhP5dbBS
	VZ7UIHtHBSD7YsR/I5eYGnEq6j3/+ny+F79qkHKSBTiPqENf3/8ScdWbybK0wMSiFIMpM1quM34
	qpo7qFTUtX69kGMiw4IDqdTwsAsn8J/FUYgY4fqQulbJAYi7l5/jUenDL2lsqdkndGf4YociBdN
	uBN9e+Y8sGHbY4oQ0q0O66d3p5yQwS/6jNYulE6QoNkzNj9qvYumQJY8wendHR8uDJNnEbPW8yy
	i7kUksr17PhejPRXRNuRLZc690DooQAGj5SGxHUBVGPxhvvW14i8EJbgUM+
X-Received: by 2002:a05:620a:270b:b0:93f:6f8:9d72 with SMTP id af79cd13be357-93f29de6dd6mr191690285a.77.1792186979615;
        Fri, 16 Oct 2026 14:42:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1a8ee1sm312622985a.34.2026.10.16.14.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:42:59 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH 4/6] daxctl: report whole-device hotplug state in 'daxctl list'
Date: Fri, 16 Oct 2026 17:42:46 -0400
Message-ID: <20261016214248.443247-5-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016214248.443247-1-gourry@gourry.net>
References: <20261016214248.443247-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Price <gourry@gourry.net>

Report daxX.Y/state as 'hotplug_state' in 'daxctl list'. The kernel
only updates it when written, so it goes stale if blocks are toggled
individually. Report 'inconsistent' when the blocks' online state or
zone disagrees with it; online_memblocks, total_memblocks and movable
show the actual state.

The attribute only appears when daxX.Y/state exists, so output on
older kernels is unchanged. ('state' already reports 'disabled'.)

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 daxctl/json.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/daxctl/json.c b/daxctl/json.c
index cf81fe6..986b695 100644
--- a/daxctl/json.c
+++ b/daxctl/json.c
@@ -12,6 +12,42 @@
 #include "filter.h"
 #include "json.h"
 
+/*
+ * daxX.Y/state only changes when written, so it goes stale if blocks are
+ * toggled individually. Report "inconsistent" if the blocks disagree.
+ */
+static const char *hotplug_state(enum daxctl_kmem_state state, int online,
+		int total, int movable)
+{
+	int all_online = total > 0 && online == total;
+
+	switch (state) {
+	case DAXCTL_KMEM_UNPLUGGED:
+		if (total == 0)
+			return "unplugged";
+		break;
+	case DAXCTL_KMEM_OFFLINE:
+		if (total > 0 && online == 0)
+			return "offline";
+		break;
+	case DAXCTL_KMEM_ONLINE:
+		if (all_online)
+			return "online";
+		break;
+	case DAXCTL_KMEM_ONLINE_KERNEL:
+		if (all_online && movable == 0)
+			return "online_kernel";
+		break;
+	case DAXCTL_KMEM_ONLINE_MOVABLE:
+		if (all_online && movable == 1)
+			return "online_movable";
+		break;
+	default:
+		break;
+	}
+	return "inconsistent";
+}
+
 struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 		unsigned long flags)
 {
@@ -19,6 +55,7 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct json_object *jdev, *jobj, *jmappings = NULL;
 	struct daxctl_mapping *mapping = NULL;
+	enum daxctl_kmem_state state;
 	int node, movable, align;
 
 	jdev = json_object_new_object();
@@ -92,6 +129,16 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 			jobj = NULL;
 		if (jobj)
 			json_object_object_add(jdev, "movable", jobj);
+
+		state = daxctl_dev_get_kmem_state(dev);
+		if (state != DAXCTL_KMEM_UNKNOWN && num_online >= 0 &&
+		    num_sections >= 0) {
+			jobj = json_object_new_string(hotplug_state(state,
+					num_online, num_sections, movable));
+			if (jobj)
+				json_object_object_add(jdev, "hotplug_state",
+						       jobj);
+		}
 	}
 
 	if (!daxctl_dev_is_enabled(dev)) {
-- 
2.53.0-Meta

