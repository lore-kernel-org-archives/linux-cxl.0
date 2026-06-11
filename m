Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358513DB309
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191290; cv=none; b=rUkmxOaTgA5kEiJ4RG/6fkmVdW5pV1tv9yZ5CPp+Zr7u1o6Uf2XB3twutpCaP7cbANkkckU52L4d3Bbt1bDAL1AwWrQjqHAyocrGE0riVyvG6QWHNGHZ9K9g7O0pjXX2AK+bAdlst1wAE2Yh+gpz3x+9EoXHGo3G/sH+/GtMagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191290; c=relaxed/simple;
	bh=OlkNn+UrYwYAm2pZsp658+UynCsZVW2SBCI1P0aeCR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SyydAIU2Fob5Iw6TsqGoqb1YnsyzTBDe71OZv0udZ8OJ2GjDA3sKOzAAl3JetdT2nUzpzOs6qfbzWeruAXEdbwA7+kW+5Xq8tbvHggCiIF+96+obsHIgzgPs4Ls6Mv5d6VsCSdAIVMFi4c5/06GMWJYFs5U/KETBU0H1jVq/FhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BE31F00893;
	Thu, 11 Jun 2026 15:21:28 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v4 0/6] cxl: Add CXL type2 accelerator support for cxl_test
Date: Thu, 11 Jun 2026 08:21:18 -0700
Message-ID: <20260611152124.3656434-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

See individual patches for changes from previous version.
Fixed up sashiko reported issues.

The series is based on v7.1-rc7 with Dan's region devm-cxl_probe_mem()
series [1] plus a 0-day fix [2] and Alejandro's type2 series v27 [3].

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

[1]: https://lore.kernel.org/linux-cxl/5f399564-7efe-444d-a6cf-2c6176e57ad9@intel.com/T/#t
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.3/cxl-type2-enabling
[3]: https://lore.kernel.org/linux-cxl/20260609215755.8685-1-alejandro.lucero-palau@amd.com/T/#t

Dave Jiang (6):
  cxl/test: Add test for module parameters
  cxl/test: Add type2 support for mock CFMWS0
  cxl/test: Refactor platform device enumerations
  cxl/test: Add hierarchy enumeration support for type2 device
  cxl/test: Fixup hdm init for auto region to support type2
  cxl/test: Add cxl_test accelerator driver

 tools/testing/cxl/test/Kbuild      |   2 +
 tools/testing/cxl/test/accel.c     |  66 +++
 tools/testing/cxl/test/cxl.c       | 818 ++++++++++++++++++++++-------
 tools/testing/cxl/test/hmem_test.c |   3 +-
 tools/testing/cxl/test/mock.h      |   2 +
 5 files changed, 694 insertions(+), 197 deletions(-)
 create mode 100644 tools/testing/cxl/test/accel.c


base-commit: fb6e9f132f0b98c0cf99f8f08ec6ced52139d9b7
-- 
2.54.0

