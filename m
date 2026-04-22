Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190E28DC4
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898959; cv=none; b=rqifl7xWi7q8cJ1L4cYq9abPsW/5c8SJfG6L2fsQ+s8kmPCzuCYQ3tArvYFfAMhyFgqhx6MM/wlu4xxiUAiTJXFrabkDRsZObhAx46Aeq+lP3DkHNXTijlmsoCe47KmdQCGCbQSyiGdP/Fj5alyAwB7Tgz5UqHFXgcKHtb85rNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898959; c=relaxed/simple;
	bh=cazPg8mI6Kf85y48Mlq20jn/0vuJpQ4V5KDIGV/MOjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmXFbTM9OmTjiiBf17caqUIqll81PP4njCfO/KLvl5wyGZGiEof2svKeg0uRkxS8e0j3lsSOaxxvrPhW55cH81QjSv0Bc50NzLyBdpII8ucKoFifi/nA2VUjCvchaZz5pdc+xLFmobu5QXlLUzykNv02tW53B9tgyAXy7TwtIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A96C19425;
	Wed, 22 Apr 2026 23:02:38 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Subject: [PATCH 0/7] cxl: Add CXL type2 accelerator support for cxl_test
Date: Wed, 22 Apr 2026 16:02:30 -0700
Message-ID: <20260422230237.2599333-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is based on v7.0-rc7 with Alejandro's type2 series [1] and
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


Dave Jiang (7):
  cxl/test: Refactor mock_init_hdm_decoder() to prep for type2 decoder
  cxl/test: Add type2 support for mock CFMWS0
  cxl/test: Refactor platform device enumerations
  cxl/test: Add hierarchy enumeration support for type2 device
  cxl/test: Fixup hdm init for auto region to support type2
  cxl/test: Add cxl_test accelerator driver
  cxl: Fix double unregistration of CXL regions for type2 devices

 drivers/cxl/core/region.c      |   3 +-
 tools/testing/cxl/test/Kbuild  |   2 +
 tools/testing/cxl/test/accel.c |  71 ++++
 tools/testing/cxl/test/cxl.c   | 717 ++++++++++++++++++++++++---------
 4 files changed, 605 insertions(+), 188 deletions(-)
 create mode 100644 tools/testing/cxl/test/accel.c


base-commit: 6fa897f2d9a917c4bd7b911b230fcfad05a952c2
-- 
2.53.0

