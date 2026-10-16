Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93150447805
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186987; cv=none; b=tCanOLhpHuinuBct4Es5q+il/tACy/XXNltHxcCQI/54D3gKRgeQljm/D1a0ghwq9aTF6IZu7zzv403BlNlx7zq6gk3nV+EL8LnHHJzVawKL2oXY7m6iZ7FO/SG67RmH/YYRvP2tXD5WL3fsX/0emyrnK9vh7LbzkpfcRHshiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186987; c=relaxed/simple;
	bh=hckdEyUJ8XXReuziTgLHvj1aSK3PhY7w+gNx7VOLcMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+dEU0IrunD+QyMv0gYf+l3IiTC5l+uifq9P+ozCdWSoslPF2oz371wwub0zS4rx8LMPrQlgN11lTGyIYEX2Jo4DYexQJqJH4Jx6I1xT1hk+oaTD/VvknOjGxP1Ej/bw6M6gcmlIdNBIrb82ccFz0O4BwHQMgzwizo36sQ0Ae6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dBJmhJIl; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dBJmhJIl"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e63ee7b4cso35238385a.2
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 14:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792186983; x=1792791783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SOw+IILdCxMEGN7nWIcZs76snWj85SrKxmlvxOvNYy8=;
        b=dBJmhJIlDW5gtglXXEV6Q5le2Zzct9MZFF7u6xm8SD/Kw1dL9ksbFm6A/XhnWsbTpn
         Jiyl/F8CXEd5iYachTMP1fWGDRZYyaAqxkR1c91RgIrgZp1uZn8+T4ddSf2nKqhAU6G3
         EivlHAS1fMEzBYIEdNTwUHncDgdUy9aEMPO4J/TY2zEB6FIHbA5vgjOZ/3vwYktBULes
         4agNItVp7TyRh/W8/VxX9lIt0D+IUj2GtaNaf6Tu2nETDbzgj/xmC/NQbWOYdNiHCItF
         ZCIIsgFKLGXi+dh88gcjgizpLQztiPgKQGp2CGmzjc0Pd+9Ac5OUxV00eq7zsA+7a3gk
         rhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186983; x=1792791783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SOw+IILdCxMEGN7nWIcZs76snWj85SrKxmlvxOvNYy8=;
        b=s8yKZm4eZdvNmZDasNnVV9fSa80v3e7IhbO8iBZ/252TDWwPoQy9flXdSnCHShLh4W
         XzqpIH1zBoiJYlrFDCcMpHfhH+aDykznBa+3ia1I/wsT+LkBnizXdtvkAiThHb1cN5W5
         1NfqU+YOmwjZT893dmo1K9/p1fsdyBU342aDmwAkQHu8BKe1wyIr1jJxg/tO1K2W2G3k
         WDyQIJ+zJ/DNWAkXhc0vze5eQQN5AKUphVCmciPX1RntQ+c4nPIZJshsOUQDuL9UrMba
         nbMtqopXH0jL4gUYDa8N3mqPPIYrBzGgttCZrYXf8i5PYY7dTFHq/pID7XFHFy2xJQtR
         omGw==
X-Forwarded-Encrypted: i=1; AKwUvBzOcCrl9C8A4VnQdrMUikTrueXCeleZTzLyMK+AJTIzmxWP3UrIiWTdwgWZ0OSTBpRJjsfzw9ZKk7k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOKMEoX+0wB2QqjMrEmvHNLh/GQgUb4XHCoh13tpsk8uK1xzUE
	0GCIEVDI+UI0slGT/vWigIfN8Kd0wIBIdDwIgPbL7RWObHUgExLsCIHmIX1jHF8RQjj40BvVU75
	hy59PJiw=
X-Gm-Gg: AYBFou1EM1A9Ws/mg+PzjOO1wQsv52Hv9XKM+qE53YiJ3rpOUvcQvKLdGziX8iEX4zA
	pHiLRt6/PQ3eASZJter+E/MTdYeNHUKd+4hTsv873UFiJpYkh9MdbxsJ33sNkLBpjmFS/hGVnB2
	k3iEs312qpoq5L0YffdDQ2OSt/8sH0TZQZjbkt5Y5SSsrUfExBqMzS4f4r3ZavIpJxAAe2DGUJO
	MuA8U/qI52W2xxz4McW8HK0MikzeystzE7+wU7w4Tch9K7daT5Df1MWjRWd+Qyl73n5P42WIeMj
	m34VIwz3N33yoYeGqWFciAszluoclVTmpHDFKRVCy0IKXCK6dXPlWxAi6AovLtv6Tr/6WKpzOy2
	e/D+Gv2+fP8VZEQHchiSLdkkWcltQVudYim3bcP5axwGxlgU61sIXd068yQz+f2TvrVLJgn3mPh
	xmL6PpuecAZuQMTihvEamuCJL3o/V+VF1vXcI3iObNYmJUNR4Iafyta0nuiDp0HTetRqIUS/V1H
	g8po93T+KykWMT12NSbjheVgiB7MFwipM3tATiore7hJ2T+/XjfkkzP9z9u
X-Received: by 2002:a05:620a:371f:b0:939:a199:45b4 with SMTP id af79cd13be357-93f29d394a1mr199987685a.39.1792186982404;
        Fri, 16 Oct 2026 14:43:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1a8ee1sm312622985a.34.2026.10.16.14.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:43:02 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH 6/6] test/daxctl-devices.sh: cycle offline/online to cover unplug and replug
Date: Fri, 16 Oct 2026 17:42:48 -0400
Message-ID: <20261016214248.443247-7-gourry@gourry.net>
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

Repeat the online/offline pair to cover onlining from 'unplugged', and
check that offline-memory unplugs an already offline device. After each
step, check block counts and, where present, daxX.Y/state and the
'hotplug_state' reported by 'daxctl list'.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 test/daxctl-devices.sh | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/test/daxctl-devices.sh b/test/daxctl-devices.sh
index 659428d..cdb13f6 100755
--- a/test/daxctl-devices.sh
+++ b/test/daxctl-devices.sh
@@ -67,6 +67,40 @@ daxctl_get_mode()
 	"$DAXCTL" list -d "$1" | jq -er '.[].mode'
 }
 
+daxctl_get_online_blocks()
+{
+	"$DAXCTL" list -d "$1" | jq -er '.[].online_memblocks'
+}
+
+daxctl_get_total_blocks()
+{
+	"$DAXCTL" list -d "$1" | jq -er '.[].total_memblocks'
+}
+
+check_memory_online()
+{
+	local total
+
+	total=$(daxctl_get_total_blocks "$1")
+	(( total > 0 ))
+	[[ $(daxctl_get_online_blocks "$1") == "$total" ]]
+}
+
+check_memory_offline()
+{
+	[[ $(daxctl_get_online_blocks "$1") == "0" ]]
+}
+
+# skipped on kernels without daxX.Y/state
+check_kmem_state()
+{
+	local path="/sys/bus/dax/devices/$1/state"
+
+	[[ -f "$path" ]] || return 0
+	[[ $(cat "$path") == "$2" ]]
+	[[ $("$DAXCTL" list -d "$1" | jq -er '.[].hotplug_state') == "$2" ]]
+}
+
 set_online_policy()
 {
 	echo "online" > /sys/devices/system/memory/auto_online_blocks
@@ -100,7 +134,26 @@ daxctl_test()
 	"$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"
 	[[ $(daxctl_get_mode "$daxdev") == "system-ram" ]]
 	"$DAXCTL" online-memory "$daxdev"
+	check_memory_online "$daxdev"
+	check_kmem_state "$daxdev" "online_movable"
 	"$DAXCTL" offline-memory "$daxdev"
+	check_memory_offline "$daxdev"
+	check_kmem_state "$daxdev" "unplugged"
+	# again, now from 'unplugged' where supported
+	"$DAXCTL" online-memory "$daxdev"
+	check_memory_online "$daxdev"
+	check_kmem_state "$daxdev" "online_movable"
+	"$DAXCTL" offline-memory "$daxdev"
+	check_memory_offline "$daxdev"
+	check_kmem_state "$daxdev" "unplugged"
+	# an already offline device is unplugged too, where supported
+	if [[ -f /sys/bus/dax/devices/$daxdev/state ]]; then
+		"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+		"$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"
+		check_kmem_state "$daxdev" "offline"
+		"$DAXCTL" offline-memory "$daxdev"
+		check_kmem_state "$daxdev" "unplugged"
+	fi
 	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
 	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
 	"$DAXCTL" reconfigure-device -m system-ram "$daxdev"
-- 
2.53.0-Meta

