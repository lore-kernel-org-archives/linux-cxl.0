Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k35L+9jR"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0912120
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 21:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702014167; x=1733550167;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=c1TEBn/2X/gSuC/6BNRmNuO2xL6V6S04qm74wlTvV4s=;
  b=k35L+9jRbmN6vSh8LhZlbBZs/yeh+3YjJhd33gsIP2XeiDJNe7eymWsw
   yinRqMIkNvyzv2qi/F/zA78eNEh554PI4XNjUtA101HLUJOOkk73n95Uw
   Cz+pV9v1gvEkTwLujUEZCPhkRKaw7PmSEdNjOTF0y5iHWRw57Wgdjx1Cg
   U1+1zdD2J4/I9I8kGk4TuMRwEPjNxh7/1JZzhXHQyn9cEVmrZPKojCpn3
   ryGo7HCMUmHVSZMkS1W2I8w9mEXjIBe2i1EYTPlXOr5T26g+jiDNpsDt4
   nyiwbKYFwosCnBrg54fKkRazIZkdD99urj6dcPVCD8VJLBu/RhgZjcfkV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="480557768"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="480557768"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 21:42:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="772017289"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="772017289"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.218.173])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 21:42:45 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 07 Dec 2023 21:42:37 -0800
Subject: [PATCH b4] am: Build patch series when additional patches appear
 in a thread
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231207-series-from-non-reply-reply-v1-1-cb02de53857c@intel.com>
X-B4-Tracking: v=1; b=H4sIAMyscmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIwNzXYh63bSi/FzdvPw83aLUgpxKKGloaJBqYmFhmJRokKYENKGgKDU
 tswJserRSkolSbG0tAErmMtFxAAAA
To: tools@linux.kernel.org
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 Robert Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org, 
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-68ec7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702014165; l=4051;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=c1TEBn/2X/gSuC/6BNRmNuO2xL6V6S04qm74wlTvV4s=;
 b=GbqOlnbKqBqZxocKpGsVrCwUMAjWB+0MpoDvLPmNBc6Y5ao1p27g3ZNzGfM6VCv0C1Lw2tU9p
 Ay2vsPkuHykDZ2cq7lI35VWzScfJZ86lzjP+R8YafnArs5FhAPpIdAh
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Dan reported that am/shazam cherry-pick was failing with a particular
CXL series.[1]

	$ b4 shazam -S -P _ 20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com
	Grabbing thread from lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/t.mbox.gz
	Checking for newer revisions
	Grabbing search results from lore.kernel.org
	Analyzing 8 messages in the thread
	Specified msgid is not present in the series, cannot cherrypick

The reason is series processing failed to detect that a non reply follow
on message containing a patch was not a replacement for the original.
The way this patch was submitted (without a 'Re:' subject prefix) is
actually a good thing.  This is because a reply would have implied a v2
to the original patch rather than a follow on patch as intended.

Teach b4 to interpret a thread like this by adding the additional patch
to the series with a warning.  The series can then be applied as normal
or with a cherry-pick as was necessary in this case.

A run after the fix looks like this:

	$ b4 shazam -S -P _ 20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com
	Grabbing thread from lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/t.mbox.gz
	Checking for newer revisions
	Grabbing search results from lore.kernel.org
	Analyzing 8 messages in the thread
	WARNING: duplicate messages found at index 1
	   Subject 1: cxl/cdat: Free correct buffer on checksum error
	   Subject 2: cxl/pci: Get rid of pointer arithmetic reading CDAT table
	  2 is not a reply... assume additional patch
	Checking attestation on all messages, may take a moment...
	---
	  ✓ [PATCH] cxl/cdat: Free correct buffer on checksum error
	    ✗ No key: ed25519/ira.weiny@intel.com
	    ✓ Signed: DKIM/intel.com
	    + Reviewed-by: Robert Richter <rrichter@amd.com> (✓ DKIM/amd.com)
	    + Reviewed-by: Fan Ni <fan.ni@samsung.com> (✗ DKIM/gmail.com)
	    + Reviewed-by: Dave Jiang <dave.jiang@intel.com> (✓ DKIM/intel.com)
	---
	Total patches: 1 (cherrypicked: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>)
	---
	 Base: using specified base-commit 7475e51b87969e01a6812eac713a1c8310372e8a
	Applying: cxl/cdat: Free correct buffer on checksum error

[1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 b4/__init__.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/b4/__init__.py b/b4/__init__.py
index 7d665f9e2c0a..f87daf838b4f 100644
--- a/b4/__init__.py
+++ b/b4/__init__.py
@@ -481,10 +481,20 @@ class LoreSeries:
         if self.patches[lmsg.counter] is not None:
             # Okay, weird, is the one in there a reply?
             omsg = self.patches[lmsg.counter]
+
+            logger.warn('WARNING: duplicate messages found at index %s', lmsg.counter)
+            logger.warn('   Subject 1: %s', lmsg.subject)
+            logger.warn('   Subject 2: %s', omsg.subject)
             if omsg.reply or (omsg.counters_inferred and not lmsg.counters_inferred):
                 # Replace that one with this one
-                logger.debug('  replacing existing: %s', omsg.subject)
+                logger.warn('  2 is a reply... replacing existing: %s', omsg.subject)
+                self.patches[lmsg.counter] = lmsg
+            else:
+                logger.warn('  2 is not a reply... assume additional patch')
+                self.patches.append(None)
+                self.expected = self.expected + 1
                 self.patches[lmsg.counter] = lmsg
+                self.patches[lmsg.counter + 1] = omsg
         else:
             self.patches[lmsg.counter] = lmsg
         self.complete = not (None in self.patches[1:])

---
base-commit: 433a845ce33f33c2ded6875447bf18e186ea1865
change-id: 20231207-series-from-non-reply-reply-110e4881ba0f

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

