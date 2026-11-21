Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795262713;
	b=FBY2B/GZfbATmnnuHGvKb+RdxwvgvIqZ/Hf6k9qiQmKpmsoCxXsS2yhvFtNsWHOvI0qf
	 CRwAuqz8h1DSbPsShTwEz3qlkLbBmUOVUuXGET+/TVY10VdW3JGnJrVQif2xGkwlAhbEP
	 fu62KwaFWhxdaOTWsdgU/ScbqADYp1kqOCVBmMxjMr827eMsOYz40tDn9AmrR0OfIIKtb
	 WHwMvEBkYKZ4b8maOi1Xa6/fvHA7jlWiRuIjxi3uilSA5rikJo5/so8IAxeH/PPjNu/a7
	 lgWPpzN0gEmMic4lac0qiDC7B+/7mFFqG9alfR0SA5fnO2GTwOnOwWQiDb1aWG5N90Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2N0f8Hnh84LuhQkUbe8zo17SuoG8Y6Lvd2KUvSPrbpY=;
	b=hxX+NcPrWnxHcGiG4qZoplCVJb3xflVZhslgJ8rbsb6WAISdtl+GV1FZldJLVhRrI6m+
	 DiV1M/XughNJZZDtidpgBi/UAepYC+Udw0Hto4Hz5qnYo17I8rnXRCSQTu8LPvXtoChx7
	 YgriQ0DYeJCmU75hHXmqBHP3JL54XYp1Z4OtkuKcXk787BtNhrssUNMRLHI1/Y94gx2v/
	 rVdVdzHaz0ixM9WKtIugJybQq2Lam6lFSIBAVIvbtDMYN2LvfJ7EHU3+pHHr/IyjbMV0b
	 rNxh6yVgv9ytDCv+2ZVB+2DeEcilodyLYc/Nz5dS9org0N/Teo2WsNVzoKBNiAfqIOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GvYqcO17;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788E606A32C
	for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 12:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8788E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GvYqcO17
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so1544961b3a.0
        for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 04:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795262713; x=1795867513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2N0f8Hnh84LuhQkUbe8zo17SuoG8Y6Lvd2KUvSPrbpY=;
        b=GvYqcO17g6WpnQubwJyUD4qVaGWGsyrb3+vDZkx+LP34XoCVXiLgUJfu06nEmtGd7t
         D47mj+ughCeLSX0e70od6roIsf/F2gdaoZVuUTnfe62YxR3iexQW9plRdo/phARQ7wSn
         t3xMff7cTGiAaDF0lt6FKp2UumpzxrSusG9kKWN8WzeLMcoSUrqRj4MnduibSf6tdaQ2
         b7FHOF4ip9OnAUsscoo/cOBhRsJzwYrdKdBORkJOSyvF4GJJpl0MOf8JmEXhLsJH33J+
         C0oy3KFz+4erdBRtVRMF7IxWDrXwgfAOC+tg+uF/HF4tw4/E2UexNpNY3l5k0+7M1Ce7
         NDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262713; x=1795867513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2N0f8Hnh84LuhQkUbe8zo17SuoG8Y6Lvd2KUvSPrbpY=;
        b=0P6y28nK2JgMeTLReHgDlUMcoj0UAU4YlNs++bU/jyjXSPd9UJIdzQoNVYM4/ih9Sg
         wLQg/ujHIFdIprwqU8JSDtULIp9CndF0i0eAPwt9hZMclHWvTtQVYT9jixq5F2uXgw3p
         8h4PXGFCUPRCFkSoc+mA19KPVpnlXp02x54GzW7vnChmDAaL10+6wUU3DtuIASmHCWZv
         QtLd+F+IWo8BsrRxQSvsVJ2YSav0iARdm600n8nI2LDFygF8ZYyQXmiQNF1i6hX+D7js
         n6Niw/ehdXfr38/W6ZT0TE2oTFEWzW/HxREbVfXc+lQZQ1EZGzDhRc3Q/W4DiYuu6WgQ
         9DMw==
X-Gm-Message-State: APuU4Z/87yxhmmzrMLR4ogXfu37uICUCw9IiasuQPE5vD2QzB9wVX1k+
	E6sYoYidt+lVmzCMeOvKduIaL1VJK0i58p2HZHDv73KK5bXDeeEvRezHIqf0R2FV
X-Gm-Gg: AZFdTZeTVSMqYvbvy2VcHgwrnelX0Rtoe587FOJsxLAQNt22hZ0hRkfDvtftkZp3NWZ
	coDNMjWh7SlX4P6apjXSH05QQxlludOMuRQC9139X/4HRSRz/8w/gXHo2EtDKW9L6Plo8dxQTmp
	Zdzh5MDkM4oT6BDu29EBCwahjLQnHmi6jye9snhhJWChpbf7dZCZvdDJmMcwo4sRVmSEyJrPVWo
	g6cZBWu1YE05MAPI71jiYV3tLXOwWZHKp76OWrgZFM9bDxc252uua3cDKVjz5Yt6wv49+yls/a3
	3aEXSIYEGUHnPqlwNN54teSjkh8Aodw7WKYu9nlE2rwmj6QY+Kc2LEkuusPrIIdhiGOgm9ELqz6
	+/pFH7cZYUbH91oXzguGU7dtslCFLUitA3sQ/Wt/ixx02gTgs20tIyjW1UnkO9/Yi5O9GKY5HgW
	+Z/rND0cPgoNqU0k9ah+vkO1wk0nKF7uBszmh4UqSKrPlKaTgQ6XXrODZ+yRWZBvhZ+Q0w9XsiY
	ODW7dlQ5zpyur1gDpY26+VJ8iAWHg7G/ZApF6/bK5WTfSU25tlk1MpYVL/G5YctbafE+Jzeak5Y
	Yd7Cp35YGAP6axx9Licbv4WFYYkEElEDgaG7Cxq5sN8=
X-Received: by 2002:a05:6a00:4388:b0:8a0:1acb:677a with SMTP id d2e1a72fcca58-8c87d806cf8mr5796736b3a.57.1795262712765;
        Sat, 21 Nov 2026 04:05:12 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm2857177b3a.1.2026.11.21.04.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:05:12 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 0/3] cxl/memdev: Fix update-firmware --wait after a failed upload
Date: Sat, 21 Nov 2026 21:05:03 +0900
Message-Id: <20261121120506.1562043-1-unsung0317@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'cxl update-firmware --wait' does not return after an upload that was
cancelled or failed, because it also waits for remaining_size to reach
0 and the kernel leaves remaining_size as it was on errors. Patch 2
waits on the loader status only and extends the cancel test to cover
it. Patch 1 fixes the test helper that was meant to catch a hang like
this but never times out. Patch 3 makes '-F <file> --wait' fail when
the upload ended with data left, so a script can tell a failed update
from a successful one.

Reproducer on a cxl_test or QEMU memdev:

  cxl update-firmware -F fw.bin mem0
  cxl update-firmware --cancel mem0      # while still transferring
  cxl update-firmware --wait mem0        # never returns before patch 2

Tested on a QEMU CXL type 3 memdev, 10 runs per case, each --wait under
'timeout 60' (exit code in parentheses):

  case                              v85         with this series
  normal upload with --wait         returns (0) returns (0)
  --cancel during transfer, --wait  timed out   returns (0)
  --wait alone after a cancel       timed out   returns (0)
  ->prepare() fails (busy), --wait  timed out   returns (1)

and with 'meson test cxl-update-firmware.sh' against cxl_test on
lockdep and KASAN kernels: the series passes; the patched test with the
v85 cxl/memdev.c fails at the new --wait check, and the test of patch 3
fails with the cxl/memdev.c of patch 2. The whole cxl test suite gives
the same results with v85 and with this series.

An LLM-based tool was used to check that the experiments were safe to
run and to drive the repeated test runs.

Patch 3 only sees failures that leave remaining_size non-zero, that is
a ->prepare() failure or a failure or cancel during the transfer. A
failure in the programming step leaves remaining_size at 0 and still
exits 0. Reporting that needs the loader 'error' attribute
("programming:hw-error" etc.), which libcxl does not read; I can add an
API such as cxl_memdev_fw_update_get_error() if that is the preferred
direction. With several memdevs, the command still exits 0 when any of
them succeeded, as for the other memdev commands.

Unsung Lee (3):
  test/cxl-update-firmware: Make wait_complete() honor its timeout
  cxl/memdev: Stop waiting on remaining_size in update-firmware --wait
  cxl/memdev: Fail update-firmware --wait when the upload did not
    complete

 Documentation/cxl/cxl-update-firmware.txt |  5 +++
 cxl/memdev.c                              | 15 ++++++--
 test/cxl-update-firmware.sh               | 42 +++++++++++++++++++----
 3 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.34.1

