Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1191D5170
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226660; cv=none; b=C9SfXbWuA5r7WrHVilOkc7VJp901bLjjt778FN/ifmtu3VMywwCPwXLqPCwKSEgxnlCQyVJ+BuMUPJzSxJF47RNhIoIrjfnONhSbYhysBSGd1Eeo/+FgT9jHFR3AQvEKw9PcqK4UJYW3sYdzipQOPZtQWHXGQcdzgvPmfzuJOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226660; c=relaxed/simple;
	bh=MyQzguiPRTxaaTlo/I2hoLO36sbyDBdg2G+I/L6fuV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDrS7hxXamIVHU1R2Ak++a7JfcI9bZi+/LVjZBAnHKTNuqyuySjdDuLDnebKIYntnYsobg+/xlzqeiplIrsJvF6XoLmuDr3nXXHRSCaG5Hp/WJz0z+BzsRSg8S6P9zZ/hG/ypldfauAzHZiO4L2ouk2KZaL2CiqEd28CUTByZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E141F000E9;
	Tue, 19 May 2026 21:37:39 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v2 0/6] cxl: Add CXL type2 accelerator support for cxl_test
Date: Tue, 19 May 2026 14:37:27 -0700
Message-ID: <20260519213734.69737-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

See individual patches for changes from previous version.

The series is based on v7.0-rc7 with Alejandro's type2 series v25 [1] and
with Dan's follow on series [2].

Series adds a 'type2_test' module parameter where it setup a mock type2
hierarchy with a mock type2 accelerator device directly under a root
port that has an auto region setup.

It also includes a CXL fix that was encountered when running tests with
the new code.

[
  {
    "memdevs":[
      {
        "memdev":"mem0",
        "ram_size":536870912,
        "ram_qos_class":42,
        "host":"cxl_type2_accel.0",
        "poison_injectable":false
      }
    ]
  },
  {
    "regions":[
      {
        "region":"region0",
        "resource":70300293136384,
        "size":536870912,
        "type":"ram",
        "interleave_ways":1,
        "interleave_granularity":4096,
        "decode_state":"commit"
      }
    ]
  }
]

    "root decoders":[
      {
        "decoder":"decoder0.0",
        "resource":70300293136384,
        "size":1073741824,
        "interleave_ways":1,
        "accelmem_capable":true,
        "qos_class":42,
        "nr_targets":1
      },

[1]: https://lore.kernel.org/linux-cxl/20260330143827.1278677-1-alejandro.lucero-palau@amd.com/T/#t
[2]: https://lore.kernel.org/linux-cxl/20260403210050.1058650-1-dan.j.williams@intel.com/T/#t


Dave Jiang (6):
  cxl/test: Add test for module parameters
  cxl/test: Add type2 support for mock CFMWS0
  cxl/test: Refactor platform device enumerations
  cxl/test: Add hierarchy enumeration support for type2 device
  cxl/test: Fixup hdm init for auto region to support type2
  cxl/test: Add cxl_test accelerator driver

 tools/testing/cxl/test/Kbuild  |   2 +
 tools/testing/cxl/test/accel.c |  74 ++++
 tools/testing/cxl/test/cxl.c   | 629 ++++++++++++++++++++++++++-------
 3 files changed, 571 insertions(+), 134 deletions(-)
 create mode 100644 tools/testing/cxl/test/accel.c


base-commit: f47d7b8dbd872ba638dd9b2c25efae2d6cd14dca
-- 
2.54.0

