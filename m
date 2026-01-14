Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882E38BDC7
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768434406; cv=none; b=Wy5tjya3mgI8PDDfP2yfWLjHYl8OpZHtyYDLqY0kmHMFHswOE0RiM15nxdNysc+wdw2+NAv8rNXOmLm/3vKL/G3Fck5AKQXRHYUEEb9OD3OZ+jakmqm82GVAMV2gVZsdK47AAYViDfXveXMlx31jFQR1Dm/E5In7aYosYHRdOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768434406; c=relaxed/simple;
	bh=EHMwJPD2Vt6csWKDxVM2bpGH+6rPVOBI0T+ZdejS8PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPvPumZLzKMqXbQrUJCHn8fR6+4ONLrMmNkjJb99FNc21RBWDPWCSqOeVUtzFy16T1Dkgg6NLZYfjBZtZ4+cQL5OpdYKjO5DWag2mYBaQSVhyLY1s97pmgn0drvul3QVd01bv6bOsBWNP7Hcy82wihUzWGGh7ve0VXmvEX/58W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMNQSINV; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMNQSINV"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12332910300so897785c88.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 15:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768434398; x=1769039198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIEMUdHe6tYyV62gaPFR8QpHnKQnU3PaCpWSzsgNDe8=;
        b=FMNQSINVWCxCDaWVaetb4YXgKpWbOzCREdzexjSoXfBnTO8wNyloCl7V2gsF7dMi4/
         ZXoGvkzAkPQRCz5sU5MvVnlXZsfChCJ7vIGuTCv7qCaQ32PjvwD2DXZZDUh/Nsc4Iuxe
         4ffdV8ZBG0fc3nCyQnvt2FqelxzVCWh12LCGx2aHBCz8pq13O+myGKWO8+f7MtMwUfy+
         lMzHBjYkqJucfwANcZO9k2+F+FPA+Jn0DnOZVPTbqV5aM79OzzhD19hpZXxjR76NkcUn
         Ed870a/9ZwYOWMnDkuCHa9MdsjZEZ2/avwMrKpAEnnz62wL8mnPtAWHrxq4aBq+mY+1a
         m/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768434398; x=1769039198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIEMUdHe6tYyV62gaPFR8QpHnKQnU3PaCpWSzsgNDe8=;
        b=JlKknxfQG6KvXxDjeYlzl2MIUJDaPEmijtx0Dm/3/GDcV6Y79OhlmAeQu25G3ybSdO
         9rmLE/Z7JHm5eb0ahFNenpQdEa4qElmfCasrH/mkJuerQYV7k6sbFM/gmefg4rJMhU4d
         Ng4Eq7fmN/pHZPRN0g0JyggeevM2XVrEfzqDiVS5OLzNwPqzfIsZPcAcsdxLErgjpYxD
         uJdikKAVfrE7BxBCABIpwdirZAUg1fJcYa8TAoKb24u91uKDTvEJjl4klKEtt+tXBktx
         XWN0ktoSK3iucYoBzth2X8T3hj9+rECYNk+sZs15ngM7eY2s6FQBt2uJYiMOicVdOgdC
         FcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV6W2Bi4vUFh2pWTPQFMcLCCM4HEGVyt+fvcrpxipWcTfhvsD9uazIdQSRRU2M2jL1r/04rMKuCg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Cx+/rtBem+69Uwxsni2Ye9LrUt3HNePNZr4lbyrZQGC4P5Ol
	yCXHbqTlDb1MRQWcEWL9NAIWsX1kPDpTYUfXqclv84PnWctxQLW/Y248/QNz8g==
X-Gm-Gg: AY/fxX5pUdsrANmp7Zn5h8/7BVqN2oO7oYhNtBrk0Rbn+oM/7UlPhptQrEAxgbX+M3+
	ThIDAUgs8igVm/RvRZWsaWNAxO9hglzLMBc4jI5Dimxkq3xXxSDc+Z4fp4J46oVWbkB+kjK5jq1
	6rbwZvr0nSUmLx13hhLQOXaLPvII8/nTKSYJ2NDreQVfKYrz7CHmCaLWe+SwAai9pkWie0sLIRg
	ROCRHkeFDPv2iXPfuLWWgxocfV7cyvfzX6g9cOVcw4XLls9nO1nMjq0oOePm/Iq39evYWKvAtvV
	UD6DHZudrcxrdYyOhaZqqCjj9Li1ajCshHZ0HvLBfprEBAp2GApJfCZhaD9izYcAvDpNNajTvQ4
	TXEpUF7SoOxcKr2IXKaKh++/FO1OIodCrQMOraF3oRVZJ4jZsHh8V1LfRCrP19EkHGAUWjaOwGP
	y7wHGRxsx3eqFb9xGqUDp2q0HNries5YAUZQqDL5NaWy2h
X-Received: by 2002:a05:6871:7817:b0:3e0:9188:8f10 with SMTP id 586e51a60fabf-40406c5d030mr2965148fac.0.1768427121522;
        Wed, 14 Jan 2026 13:45:21 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de55ffsm17644773fac.2.2026.01.14.13.45.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:45:21 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 0/2] ndctl: Add daxctl support for the new "famfs" mode of devdax
Date: Wed, 14 Jan 2026 15:45:17 -0600
Message-ID: <20260114214519.29999-1-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114153133.29420.compound@groves.net>
References: <20260114153133.29420.compound@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No change since V1 - reposting as v2 to keep this with the related
kernel (dax and fuse) patches and libfuse patches.

This short series adds support and tests to daxctl for famfs[1]. The
famfs kernel patch series, under the same "compound cover" as this
series, adds a new 'fsdev_dax' driver for devdax. When that driver
is bound (instead of device_dax), the device is in 'famfs' mode rather
than 'devdax' mode.

References

[1] - https://famfs.org


John Groves (2):
  daxctl: Add support for famfs mode
  Add test/daxctl-famfs.sh to test famfs mode transitions:

 daxctl/device.c                | 126 ++++++++++++++--
 daxctl/json.c                  |   6 +-
 daxctl/lib/libdaxctl-private.h |   2 +
 daxctl/lib/libdaxctl.c         |  77 ++++++++++
 daxctl/lib/libdaxctl.sym       |   7 +
 daxctl/libdaxctl.h             |   3 +
 test/daxctl-famfs.sh           | 253 +++++++++++++++++++++++++++++++++
 test/meson.build               |   2 +
 8 files changed, 465 insertions(+), 11 deletions(-)
 create mode 100755 test/daxctl-famfs.sh


base-commit: 4f7a1c63b3305c97013d3c46daa6c0f76feff10d
-- 
2.49.0

